import numpy as np
import torch
import matplotlib.pyplot as plt
from time import time
import matplotlib.animation as animation
import pickle
import exodusReader
import NeuralNet_to_XML

##### SET Numpy random seed to generate predictable numbers, this prevents having to save the training and validate sets
def get_rand_training_data(x,y,N):
    training_factor = N/x.shape[0]
    random_choice = np.random.random(x.shape[0])

    x_training = np.asarray([x[i] for i in range(x.shape[0]) if random_choice[i] < training_factor ])
    y_training = np.asarray([y[i] for i in range(x.shape[0]) if random_choice[i] < training_factor ])

    X = torch.tensor(x_training,dtype=dtype)
    Y = torch.tensor(y_training,dtype=dtype)
    return (X,Y)


np.random.seed(4)

dtype  = torch.float
device = torch.device("cuda:0")

#Reader exodus file data using exodusReader
container = exodusReader.get_var_vals('/home/chaitanya/projects/magpie/simulations/nn_material_test/kks/kks.e',['w_Ni','w_Cr','eta','c_Ni_metal','c_Ni_melt','c_Cr_metal','c_Cr_melt'],10)

x = np.vstack( [container['w_Ni'],container['w_Cr'],container['eta'] ])
x=np.transpose(x)

y = np.vstack( [container['c_Ni_metal'],container['c_Ni_melt'] ,container['c_Cr_metal'],container['c_Cr_melt'] ])
y = np.transpose(y)

N = 5000

X,Y = get_rand_training_data(x,y,N)

N,D_in = X.shape #1000,2
D_out = Y.shape[1]
print("D_out ",D_out)
H = 20


model = torch.nn.Sequential(
    torch.nn.Linear(D_in,H),
    torch.nn.LogSigmoid(),
    torch.nn.Linear(H,H),
    torch.nn.LogSigmoid(),
    torch.nn.Linear(H,D_out),
    )
loss_fn = torch.nn.MSELoss(reduction='sum')
learning_rate = 1e-4
optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)
t1 = time()
t =0
# #We run the epoch till the loss function drops below the threshold
while True:
    # X, Y = get_rand_training_data(x,y,training_factor)
    Y_pred = model(X)

    loss = loss_fn(Y_pred,Y)
    if t % 100 == 0:
        print(t, loss.item())
        torch.save(model.state_dict(),'nn_uo/2_component_inv.pt')

        XML_str = (NeuralNet_to_XML.getXML_format(model))
        with open('nn_uo/NN_struct_c_Ni_metal.XML','w+') as file:
            file.write(XML_str)

    model.zero_grad()
    loss.backward()

    optimizer.step()
    t += 1
    if(t>1e6 or loss.item()<1e-6):
        torch.save(model.state_dict(),'nn_uo/2_component_inv.pt')
        break

t2 = time()
print(t2 -t1)
with open('nn_uo/NN_struct_c_Ni_metal.XML','w+') as file:
    file.write(XML_str)
