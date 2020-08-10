# Using a neural netork IC

This example goes over how to train a neural network to invert concentration from chemical potential, for creating a sub-concentration IC for the KKS model. We use the [NeuralNetworkUserObject.md] and [NeuralNetworkIC.md].

## Overview

Evaluating a neural network requires two objects: NeuralNetworkUserObject and NeuralNetworkIC. The user object parses an XML structure file to reconstruct the trained neural network. It can then be evaluated by passing input parameter values, using the NeuralNetworkIC. The output values can then be assigned to the desired Variable or AuxVariable as an IC.

## Training a neural network on MOOSE Exodus data

We will first go over how to run a KKS simulation and train a PyTorch neural network on the simulation output data. As an example case, we look at an ideal solution model KKS simulation.

!listing surrogates/kks_training.i block=Outputs
