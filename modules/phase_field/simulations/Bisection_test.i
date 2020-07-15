[Mesh]
  type = GeneratedMesh
  dim  = 2
  nx   = 50
  xmax = 100
  ny   = 25
  ymax = 50
  # uniform_refine = 1
[]

[GlobalParams]
  op_num = 1
  var_name_base = eta
[]

[Variables]
  [./w]
  [../]
  [./eta1]
  [../]
  [./eta0]
  [../]
[]

[AuxVariables]
  [./bnds]
  [../]
  [./rho_0]
    family = MONOMIAL
      # order = CONSTANT
  [../]
  [./rho_1]
    family = MONOMIAL
      # order = CONSTANT
  [../]


  # [./conc_Ni_metal]
  #   family = MONOMIAL
  #   order = CONSTANT
  # [../]
  # [./conc_Ni_melt]
  #   family = MONOMIAL
  #   order = CONSTANT
  # [../]
[]

[ICs]
  [./eta0_IC]
    type = SmoothCircleIC
    variable = eta0
    radius = 30
    x1 = 0.0
    y1 = 25.0
    int_width = 10
    invalue = 0
    outvalue = 1
  [../]
  [./eta1_IC]
    type = SmoothCircleIC
    variable = eta1
    radius = 30
    x1 = 0.0
    y1 = 25.0
    int_width = 10
    invalue = 1
    outvalue = 0
  [../]
  [./w_IC]
    type = SmoothCircleIC
    variable = w
    radius = 30
    x1 = 0.0
    y1 = 25.0
    int_width = 10
    invalue = 0
    outvalue = -0.1
  [../]
  # [./rho_0_IC]
  #   type = ConstantIC
  #   variable = 'rho_0'
  #   value = '0.2'#'4.88758554'
  # [../]
  # [./rho_1_IC]
  #   type = ConstantIC
  #   variable = 'rho_1'
  #   value = '1.0'#'24.4379277'
  # [../]

[]

#kernels to calculate c
[Kernels]
  [./DT_eta1]
    type = TimeDerivative
    variable = eta1
  [../]
  [./ACInt_eta1]
    type = ACInterface
    args = eta0
    kappa_name = kappa
    mob_name = L_eta1
    variable = eta1
  [../]
  [./ACSwitch_eta1]       #Chemical GP density --> switching this kernel off or supplying omegab and omegam as functions of chemical potential fixes convergence issues
    type = ACSwitching
    Fj_names = 'omegab omegam'
    args = 'eta1 eta0 w rho_0 rho_1'
    hj_names = 'hb hm'
    mob_name = L_eta1
    variable = eta1
  [../]
  [./AcGrGr_eta1]
    type = ACGrGrMulti
    gamma_names = gamma
    mob_name = L_eta1
    v = eta0
    variable = eta1
  [../]
  [./DT_eta0]
    type = TimeDerivative
    variable = eta0
  [../]
  [./ACInt_eta0]
    type = ACInterface
    args = eta1
    kappa_name = kappa
    variable = eta0
  [../]
  [./ACSwitch_eta0]       #Chemical GP density --> switching this kernel off or supplying omegab and omegam as functions of chemical potential fixes convergence issues
    type = ACSwitching
    Fj_names = 'omegab omegam'
    args = 'eta1 eta0 w rho_0 rho_1'
    hj_names = 'hb hm'
    variable = eta0
  [../]
  [./AcGrGr_eta0]
    type = ACGrGrMulti
    gamma_names = gamma
    v = eta1
    variable = eta0
  [../]
  [./ChiDt_w]
    type = SusceptibilityTimeDerivative
    args = 'eta1 eta0 rho_0 rho_1'
    f_name = chi
    variable = w
  [../]
  [./MatDif_w]
    type = MatDiffusion
    D_name = chiD
    variable = w
  [../]
  [./Coupled_w_eta1]
    type = CoupledSwitchingTimeDerivative
    Fj_names = 'rhob rhom'
    args = 'eta1 eta0 w rho_0 rho_1'
    hj_names = 'hb hm'
    v = eta1
    variable = w
  [../]
  [./Coupled_w_eta0]
    type = CoupledSwitchingTimeDerivative
    Fj_names = 'rhob rhom'
    args = 'eta1 eta0 rho_0 rho_1'
    hj_names = 'hb hm'
    v = eta0
    variable = w
  [../]

  #Numerical inversion --> Calculates the component phase concentrations by solving w = dF_a/dc_a
  # [./rho0_func]
  #   type = MaskedBodyForce
  #   variable = 'rho_0'
  #   mask = 'w_rho0'
  #   value = -1
  # [../]
  # [./rho0_w_val]
  #   type = CoupledForce
  #   variable = 'rho_0'
  #   v = 'w'
  # [../]

  # [./rho1_func]
  #   type = MaskedBodyForce
  #   variable = 'rho_1'
  #   mask = 'w_rho1'
  #   value = -1
  # [../]
  # [./rho1_w_val]
  #   type = CoupledForce
  #   variable = 'rho_1'
  #   v = 'w'
  # [../]
[]



[AuxKernels]
  [./bnds_aux]
    type = BndsCalcAux
    variable = bnds
  [../]
  [./set_x_Ni_metal]
    type = MaterialRealAux
    variable = rho_0
    property = 'x_Ni_metal'
  [../]
  [./set_x_Ni_melt]
    type = MaterialRealAux
    variable = rho_1
    property = 'x_Ni_melt'
  [../]
[]

[Materials]
  #REFERENCES
  [./constants]
    type = GenericConstantMaterial
    prop_names =  'Va      cb_eq cm_eq km   kb    gamma L     L_eta1     kB            interface_energy_sigma interface_thickness_l'
    prop_values = '0.04092 1.0   0.2   100  1000  1.5   1     1          8.6173324e-5  100                    10'
  [../]

  #PARAMETERS
  [./kappa] #assume that three interfaces having the same interfacial energy and thickness
    type = ParsedMaterial
    f_name = kappa
    material_property_names = 'interface_energy_sigma interface_thickness_l'
    function = '3*interface_energy_sigma*interface_thickness_l/4'
  [../]
  [./m]
    type = ParsedMaterial
    f_name = mu
    material_property_names = 'interface_energy_sigma interface_thickness_l'
    function = '6*interface_energy_sigma/interface_thickness_l'
  [../]
  #SWITCHING FUNCTIONS
  [./switchb]
    type = SwitchingFunctionMultiPhaseMaterial
    h_name = hb
    all_etas = 'eta1 eta0'
    phase_etas = 'eta1'
  [../]
  [./switchm]
    type = SwitchingFunctionMultiPhaseMaterial
    h_name = hm
    all_etas = 'eta1 eta0'
    phase_etas = 'eta0'
  [../]
  [./f_b]
    type = DerivativeParsedMaterial
    args = 'eta1 eta0 rho_0 rho_1 w'
    material_property_names = 'Va kb cb_eq km cm_eq'
    f_name = 'F_b'
    function = '0.5*(kb*(rho_1 - cb_eq)^2 )'
  [../]
  [./f_m]
    type = DerivativeParsedMaterial
    args = 'eta1 eta0 rho_0 rho_1 w'
    material_property_names = 'Va kb cb_eq km cm_eq'
    f_name = 'F_m'
    function = '0.5*(km*(rho_0 - cm_eq)^2 )'
  [../]
  [./f_chem]
    type = ParsedMaterial
    material_property_names = 'hb hm F_b F_m'
    f_name = 'F_chem'
    function = 'hb*F_b + hm*F_m'
    outputs = 'exodus'
    output_properties = 'F_chem'
  [../]

  #omega as function of component phase concentrations

  [./omegab_test]
    type = DerivativeParsedMaterial
    f_name = omegab
    args = 'w eta1 rho_1'
    material_property_names = 'F_b w_b:=D[F_b,rho_1] kb cb_eq Va'
    # function = '-0.5*kb*(rho_1^2*Va^2 - cb_eq^2)'#'F_b - rho_1*w_rho_1'
    function = 'F_b - rho_1*w_b'
    outputs = exodus
    output_properties = 'omegab'
    derivative_order = 2
  [../]
  [./omegam_test]
    type = DerivativeParsedMaterial
    f_name = omegam
    args = 'w eta0 rho_0'
    material_property_names = 'F_m w_m:=D[F_m,rho_0] km cm_eq Va'
    # function = 'F_m - rho_0*w_rho_0 '
  # function = '-0.5*km*(rho_0^2*Va^2 - cm_eq^2)'#'F_b - rho_1*w_rho_1'
    function = 'F_m - rho_0*w_m'
    derivative_order = 2
  [../]


  [./chi]
    type = DerivativeParsedMaterial
    f_name = 'chi'
    args = 'eta0 eta1 rho_0 rho_1'
    material_property_names = 'F_b F_m hb hm d2fb_drhob2:=D[F_b(rho_1),rho_1,rho_1] d2fm_drhom2:=D[F_m(rho_0),rho_0,rho_0] '
    function = 'hb/d2fb_drhob2 + hm/d2fm_drhom2'
    output_properties = 'chi_test'
    outputs = 'exodus'
  [../]

  [./w_rho0]
    type = DerivativeParsedMaterial
    f_name = w_rho0
    args = 'w rho_0'
    material_property_names = 'F_m w_m:=D[F_m(rho_0),rho_0]'
    function = 'w_m'
    derivative_order = 2
  [../]
  [./w_rho1]
    type = DerivativeParsedMaterial
    f_name = w_rho1
    args = 'w rho_1'
    material_property_names = 'F_b w_b:=D[F_b(rho_1),rho_1]'
    function = 'w_b'
    derivative_order = 2
  [../]

  [./rhob]
    type = DerivativeParsedMaterial
    f_name = rhob
    args = 'rho_1 w'
    material_property_names = 'hb'
    function = 'rho_1'
    derivative_order = 2
  [../]
  [./rhom]
    type = DerivativeParsedMaterial
    f_name = rhom
    args = 'w rho_0 eta0'
    material_property_names = 'hm(eta0)'
    function = 'rho_0'
    derivative_order = 1
  [../]
  [./concentration]
    type = ParsedMaterial
    f_name = c
    args = 'rho_0 rho_1'
    material_property_names = 'hm hb Va'
    function = '(hm*rho_0 + hb*rho_1)'
    outputs = exodus
  [../]

  [./mobility]
    type = DerivativeParsedMaterial
    f_name = 'chiD'
    material_property_names = 'chi'
    constant_names = 'D0 kB T Em'
    constant_expressions = '1e3 8.617e-5 1000 1e-5'
    function = 'chi*D0*exp(-Em/kB/T)'
    outputs = 'exodus'
  [../]

  ##Bisection method
  [./bisection_Ni_metal_conc]
    type = BisectionMethod
    f_name = 'w_chem_metal'
    material_property_names = 'x_Ni_metal kb cb_eq'
    function = 'kb*(x_Ni_metal - cb_eq)'
    x_var = 'x_Ni_metal'
    a = -0.2
    b = 1.2#0.9999999999999
    err_thresh = 1e-15
    y_val = 'w'
    N = 50
    # y_func = 'w_chem_metal'
    outputs = 'exodus'
  [../]
  [./bisection_Ni_melt_conc]
    type = BisectionMethod
    f_name = 'w_chem_melt'
    material_property_names = 'x_Ni_melt km cm_eq'
    function = 'km*(x_Ni_melt - cm_eq)'
    x_var = 'x_Ni_melt'
    a = -0.2
    b = 1.2#0.9999999999999
    err_thresh = 1e-15
    y_val = 'w'
    N = 50
    # y_func = 'w_chem_metal'
    outputs = 'exodus'
  [../]
  [./global_Ni_conc]
    type = ParsedMaterial
    f_name = 'bisect_Ni_conc'
    material_property_names = 'x_Ni_metal x_Ni_melt hb hm'
    function = 'hb*x_Ni_metal + hm*x_Ni_melt'
    outputs = exodus
  [../]

  ##GPM formula inversion
  [./rho_metal]
    type = ParsedMaterial
    f_name = rho_metal
    args = 'w'
    material_property_names = 'Va kb cb_eq'
    function = 'w/kb + cb_eq'
    # derivative_order = 1
  [../]
  [./rho_melt]
    type = ParsedMaterial
    f_name = rho_melt
    args = 'w'
    material_property_names = 'Va km cm_eq'
    function = 'w/km + cm_eq'
    outputs = exodus
    # derivative_order = 1
  [../]
  [./concentration_analytical]
    type = ParsedMaterial
    f_name = c_analy
    material_property_names = 'rho_melt hm rho_metal hb Va'
    function = '(hm*rho_melt + hb*rho_metal)'
    outputs = exodus
  [../]

  [./error_bisection]
    type = ParsedMaterial
    f_name = 'err_conc_bisection'
    material_property_names = 'c bisect_Ni_conc'
    function = 'c - bisect_Ni_conc'
    outputs = exodus
  [../]
  [./error_analytic]
    type = ParsedMaterial
    f_name = 'err_conc_analy'
    material_property_names = 'c c_analy'
    function = 'c - c_analy'
    outputs = exodus
  [../]

  [./error_bisection_mu]
    type = ParsedMaterial
    f_name = error_bisection_mu
    material_property_names = 'w_chem_metal'
    args = 'w'
    function = 'w-w_chem_metal'
    outputs = exodus
  [../]

  # [./w_chem_metal]
  #   type = ParsedMaterial
  #   f_name = 'w_chem_metal'
  #   material_property_names = 'conc_Ni_metal km cm_eq'
  #   function = 'km*(conc_Ni_metal - cm_eq)'
  # [../]

[]

[Preconditioning]
  [./SMP]
    type = SMP
    full = true
  [../]
[]

[Postprocessors]
  [./total_F]
    type = ElementIntegralMaterialProperty
    mat_prop = 'F_chem'
  [../]
[]

[Debug]
# show_parser = True
# show_top_residuals = 3
show_var_residual_norms = true
# show_material_props=true
[]

[Executioner]
  type = Transient
  scheme = bdf2
  solve_type = NEWTON
  petsc_options_iname = '-pc_type -sub_pc_type -pc_asm_overlap -ksp_gmres_restart -sub_ksp_type'
  petsc_options_value = ' asm      lu           1               31                 preonly'
  nl_max_its = 20
  l_max_its = 30
  l_tol = 1e-8
  nl_rel_tol = 1e-12
  nl_abs_tol = 1e-10
  start_time = 0
  dtmin = 1e-6
  end_time = 10.0
  automatic_scaling = true
  scaling_group_variables = 'eta0 eta1;w'
  [./TimeStepper]
    type = IterationAdaptiveDT
    dt = 0.1
    growth_factor = 2.0
    cutback_factor = 0.5
  [../]
  # num_steps = 2
[]

[Outputs]
  exodus = true
  perf_graph = true
  csv = true
[]
