#Example python script demonstrating how to train a neural network using Pytorch on Exodus data

import numpy as np
import torch
import matplotlib.pyplot as plt
from time import time
import matplotlib.animation as animation
import pickle
import exodusReader
import NeuralNet_to_XML
import random

#Randomly sample N points from the dataset
def get_rand_training_data(x,y,N):
    rand_idx = random.sample(range(x.shape[0]),N )
    X = torch.tensor(x[rand_idx],dtype=dtype)
    Y = torch.tensor(y[rand_idx],dtype=dtype)
    return (X,Y)

#Use a seed to get the same data points every time data is sampled. Only needed for testing
np.random.seed(4)

#Set PyTorch array data type
dtype  = torch.float

#Use torch.device("cuda:0") for GPU training, torch.device("cpu") for training on CPU
device = torch.device("cpu")

#Reader exodus file data using exodusReader
container = exodusReader.get_var_vals('/home/chaitanya/projects/magpie/simulations/nn_material_test/kks/kks.e',['w_Ni','w_Cr','eta','c_Ni_metal','c_Ni_melt','c_Cr_metal','c_Cr_melt'],10)

#Extracting input and output data from container
x = np.vstack( [container['w_Ni'],container['w_Cr'],container['eta'] ])
x=np.transpose(x)

y = np.vstack( [container['c_Ni_metal'],container['c_Ni_melt'] ,container['c_Cr_metal'],container['c_Cr_melt'] ])
y = np.transpose(y)

#Sub-sample the training data to a reasonable size
N = 5000

X,Y = get_rand_training_data(x,y,N)

#D_in --> number of inputs to neural net, D_out --> number of outputs from neural net, H --> number of neurons in a hidden layer
N,D_in = X.shape
D_out = Y.shape[1]
H = 20

#Create a sequential neural net model
model = torch.nn.Sequential(
    torch.nn.Linear(D_in,H),
    torch.nn.LogSigmoid(),
    torch.nn.Linear(H,H),
    torch.nn.LogSigmoid(),
    torch.nn.Linear(H,D_out),
    )

#define loss function, learning rate initial value
loss_fn = torch.nn.MSELoss(reduction='sum')
learning_rate = 1e-4

#Use adam optimizer to calculate learning rate during training.
optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)

t1 = time()

epochs =0
# #We run the epoch till the loss function drops below the threshold
while True:
    # X, Y = get_rand_training_data(x,y,training_factor)
    Y_pred = model(X)

    loss = loss_fn(Y_pred,Y)
    if epochs % 100 == 0:
        print("Epoch: ", epochs, " Loss function: ",loss.item())
        torch.save(model.state_dict(),'2_component_inv.pt')                     #Save state to allow restarting training in case the current run crashes

        XML_str = (NeuralNet_to_XML.getXML_format(model))                       #Save the neural net as an XML file. This XML format is what the NeuralNetUserObject actually reads
        with open('NN_struct_c_Ni_metal.XML','w+') as file:
            file.write(XML_str)

    model.zero_grad()
    loss.backward()

    optimizer.step()
    epochs += 1
    if(epochs > 1e6 or loss.item() < 1e3):
        torch.save(model.state_dict(),'2_component_inv.pt')
        break

t2 = time()
print("Number of epochs: ",epochs,"\nLoss function: ",loss.item(), "\nTraining time: ",t2 -t1)
with open('NN_struct_c_Ni_metal.XML','w+') as file:
    file.write(XML_str)
