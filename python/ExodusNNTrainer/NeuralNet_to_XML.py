import torch

def getXML_format(model):
    XML_str = ''
    params = model.parameters()
    modules = model.named_modules()
    XML_str+="<NeuralNet>"

    for idx,m in enumerate(modules):
        if idx > 0:
            XML_str+="<LAYER id='"+str(idx-1)+"'>"
            if (type(m[1]) == torch.nn.Linear ):
                weight_tensor = next(params)
                bias_tensor = next(params)
                m,n = weight_tensor.shape
                print(weight_tensor)
                weight = [str(i) for i in weight_tensor.data.flatten().tolist()]
                bias   = [str(i) for i in bias_tensor.data.flatten().tolist()]
                XML_str+="<TYPE>LINEAR</TYPE>"
                XML_str+="<WEIGHTS>"+" ".join(weight)+"</WEIGHTS>"
                XML_str+="<BIAS>"+" ".join(bias)+"</BIAS>"
                XML_str+="<M>"+str(m)+"</M>"
                XML_str+="<N>"+str(n)+"</N>"

            elif type(m[1] == torch.nn.Tanh):
                XML_str+="<TYPE>TANH</TYPE>"
            elif type(m[1] == torch.nn.Sigmoid):
                XML_str+="<TYPE>Sigmoid</TYPE>"
            XML_str+="</LAYER>"

    XML_str+="</NeuralNet>"
    return XML_str

if __name__ == '__main__':
    D_in = 3
    H = 5
    D_out = 1

    model = torch.nn.Sequential(
        torch.nn.Linear(D_in,H),
        torch.nn.Tanh(),
        torch.nn.Linear(H,H),
        torch.nn.Tanh(),
        torch.nn.Linear(H,D_out),
        )

    loss_fn = torch.nn.MSELoss(reduction='sum')
    model.load_state_dict(torch.load('temp/2_component_inv.pt'))

    XML_str = (getXML_format(model))
    with open('NN_struct.XML','w+') as file:
        file.write(XML_str)
