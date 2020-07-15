//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "BisectionMethod.h"

registerMooseObject("MooseApp",BisectionMethod);

template <>
InputParameters
validParams<BisectionMethod>()
{
  InputParameters params = ParsedMaterial::validParams();
  params.addClassDescription("Finds the root of a parsed material equation using the Bisection Method.");
  params.addRequiredParam<MaterialPropertyName>("x_var","Name of the variable being solved for(will be used to create a material property).");
  params.addRequiredParam<Real>("a","Lower bound of search space for x.");
  params.addRequiredParam<Real>("b","Upper bound of search space for x.");
  params.addRequiredParam<std::size_t>("N","Max iterations before stopping the bisection");
  params.addRequiredParam<Real>("err_thresh","Error tolerance for equation.");
  params.addRequiredCoupledVar("y_val", "Non-linear variable y to be used to solve f(x) -y = 0.");  // params.addRequiredParam<MaterialPropertyName>("y_func","The material property that is being solved for x. Must be of form f(x) - k =0.");
  return params;
}

BisectionMethod::BisectionMethod(const InputParameters & parameters)
  :
  ParsedMaterial(parameters),
  _x(declareProperty<Real>(getParam<MaterialPropertyName>("x_var"))),
  _a(getParam<Real>("a")),
  _b(getParam<Real>("b")),
  _n(getParam<std::size_t>("N")),
  _err_thresh(getParam<Real>("err_thresh"))
  // _y_func(getMaterialProperty<Real>("y_func"))
  {
    _y_val = &coupledValue("y_val", 0);
  }

  Real BisectionMethod::Eval(Real input_val, Real y)// const
  {
    _x[_qp] = input_val;
    ParsedMaterial::computeQpProperties();
    if(_prop_F)
      {
        return ((*_prop_F)[_qp] - y);
      }
    else
      {
        mooseError("Requested material property does not exist");
      }
  }


  void
  BisectionMethod::computeQpProperties()
  {
    Real y = _y_val[0][_qp];
    Real a = _a;
    Real b = _b;


    Real c = (a+b)/2;
    // Real f_c = ;
    std::size_t N = 0;
    // std::cout << "Starting Bisection\n";
    while(Eval(c,y) != 0 && (b-a)/2 >= _err_thresh)
      {
        // std::cout << "\n"<<_qp<<" : "<<Eval(c,y);

        if ( (Eval(c,y) < 0) == (Eval(a,y) < 0) )
          {
            a = c;
          }
        else
          {
            b = c;
          }
        N++;
        if(N > _n)
          {
            break;
          }
        c = (a+b)/2;


      }

  // std::cout << (a-b) <<"\n";
  // Eval(c,y);

  }
