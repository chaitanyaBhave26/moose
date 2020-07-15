//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "ParsedMaterial.h"

class BisectionMethod;

template <>
InputParameters validParams<ParsedMaterial>();

class BisectionMethod : public ParsedMaterial
{
public:
  static InputParameters validParams();
  BisectionMethod(const InputParameters & parameters);
  // void functionParse(const std::string & function_expression,
  //                    const std::vector<std::string> & constant_names,
  //                    const std::vector<std::string> & constant_expressions,
  //                    const std::vector<std::string> & mat_prop_names,
  //                    const std::vector<std::string> & tol_names,
  //                    const std::vector<Real> & tol_values); /// ,
                     // const std::vector<Real> & input_mat_props);
protected:
  virtual void computeQpProperties() override;
  Real Eval(Real input_val, Real y);

private:
  MaterialProperty<Real> & _x;
  Real _a;
  Real _b;
  Real _err_thresh;
  const VariableValue * _y_val;
  std::size_t _n;
  // const MaterialProperty<Real> & _y_func;
};
