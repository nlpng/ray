#!/usr/bin/env python

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import argparse
import json
import os
import random

import numpy as np

import ray
from ray.tune import grid_search, run_experiments, register_trainable, Trainable, function, sample_from
from ray.tune.schedulers import AsyncHyperBandScheduler


class MyTrainableClass(Trainable):
    """Example agent whose learning curve is a random sigmoid.

    The dummy hyperparameters "width" and "height" determine the slope and
    maximum reward value reached.
    """

    def _setup(self, config):
        self.timestep = 0

    def _train(self):
        self.timestep += 1
        v = np.tanh(float(self.timestep) / self.config["width"])
        v *= self.config["height"]

        # Here we use `episode_reward_mean`, but you can also report other
        # objectives such as loss or accuracy.
        return {"episode_reward_mean": v}

    def _save(self, checkpoint_dir):
        path = os.path.join(checkpoint_dir, "checkpoint")
        with open(path, "w") as f:
            f.write(json.dumps({"timestep": self.timestep}))
        return path

    def _restore(self, checkpoint_path):
        with open(checkpoint_path) as f:
            self.timestep = json.loads(f.read())["timestep"]


if __name__ == "__main__":
    register_trainable('tunable', MyTrainableClass)
    tune_spec = {
        "run": "tunable",
        "stop": {
            "training_iteration": 1000
        },
        "resources_per_trial": {
            "cpu": 1,
            "gpu": 0
        },
        "config": {
            "width": sample_from(lambda spec: 10 + int(90 * random.random())),
            "height": sample_from(lambda spec: int(100 * random.random())),
        },
        "num_samples": 20,
    }
    # asynchronous hyperband early stopping, configured with
    # `episode_reward_mean` as the
    # objective and `training_iteration` as the time unit,
    # which is automatically filled by Tune.
    ahb = AsyncHyperBandScheduler(
        time_attr="training_iteration",
        reward_attr="episode_reward_mean",
        grace_period=5,
        max_t=100)

    ray.init()
    trials = run_experiments(experiments={'exp_tune': tune_spec}, scheduler=ahb)
