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
  # [./c_calc]
  # [../]
[]

[AuxVariables]
  [./bnds]
  [../]
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
[]


[AuxKernels]
  [./bnds_aux]
    type = BndsCalcAux
    variable = bnds
  [../]
[]

[Modules]
  [./PhaseField]
    [./GrandPotential]
      switching_function_names = 'hb hm'
      anisotropic = 'false'

      chemical_potentials = 'w'
      mobilities = 'chiD'
      susceptibilities = 'chi'
      free_energies_w = 'rhob rhom'

      gamma_gr = gamma
      mobility_name_gr = L
      kappa_gr = kappa
      free_energies_gr = 'omegab omegam'

      additional_ops = 'eta1'
      gamma_grxop = gamma
      mobility_name_op = L_eta1
      kappa_op = kappa
      free_energies_op = 'omegab omegam'

    [../]
  [../]
[]

[Materials]
  #REFERENCES
  [./constants]
    type = GenericConstantMaterial
    prop_names =  'Va      cb_eq cm_eq km   kb    gamma L     L_eta1     kB            interface_energy_sigma interface_thickness_l'
    prop_values = '0.04092 1.0   0.2   100  1000  1.5   5.0e3  5.0e3    8.6173324e-5  100                    10'
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
  [./omegab]
    type = DerivativeParsedMaterial
    f_name = omegab
    args = 'w eta1'
    material_property_names = 'Va kb cb_eq'
    function = '-0.5*w^2/Va^2/kb - w/Va*cb_eq'
    derivative_order = 2
  [../]
  [./omegam]
    type = DerivativeParsedMaterial
    f_name = omegam
    args = 'w eta0'
    material_property_names = 'Va km cm_eq'
    function = '-0.5*w^2/Va^2/km - w/Va*cm_eq'
    derivative_order = 2
  [../]
  [./chib]
    type = DerivativeParsedMaterial
    f_name = chi
    args = 'w'
    material_property_names = 'Va hb hm kb km'
    function = '(hm/km + hb/kb)/Va^2'
    derivative_order = 2
  [../]
  #DEN1000/TES/CONCENTRATION
  [./rhob]
    type = DerivativeParsedMaterial
    f_name = rhob
    args = 'w'
    material_property_names = 'Va kb cb_eq'
    function = 'w/Va^2/kb + cb_eq/Va'
    derivative_order = 1
  [../]
  [./rhom]
    type = DerivativeParsedMaterial
    f_name = rhom
    args = 'w eta0'
    material_property_names = 'Va km cm_eq(eta0)'
    function = 'w/Va^2/km + cm_eq/Va'
    derivative_order = 1
  [../]
  [./concentration]
    type = ParsedMaterial
    f_name = c
    material_property_names = 'rhom hm rhob hb Va'
    function = 'Va*(hm*rhom + hb*rhob)'
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
    N = 1000
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
    N = 1000
    err_thresh = 1e-15
    y_val = 'w'
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

  [./error_bisection]
    type = ParsedMaterial
    f_name = 'err_conc_bisection'
    material_property_names = 'c bisect_Ni_conc'
    function = '(c - bisect_Ni_conc)'
    outputs = exodus
  [../]
  [./error_bisection_w_Ni]
    type = ParsedMaterial
    f_name = 'err_mu_bisection'
    args = w
    material_property_names = 'w_chem_melt'
    function = '(w - w_chem_melt)'
    outputs = exodus
  [../]


[]

[Preconditioning]
  [./SMP]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient
  scheme = bdf2
  solve_type = NEWTON
  petsc_options_iname = '-pc_type -sub_pc_type -pc_asm_overlap -ksp_gmres_restart -sub_ksp_type'
  petsc_options_value = ' asm      lu           1               31                 preonly'
  # nl_max_its = 20
  # l_max_its = 30
  l_tol = 1e-8
  nl_rel_tol = 1e-12
  nl_abs_tol = 1e-7
  start_time = 0
  dtmin = 1e-6
  end_time = 10.0
  # dt=0.001
# [./Adaptivity]
#  max_h_level = 1
#  initial_adaptivity = 0
#  coarsen_fraction = 0.3
#  refine_fraction = 0.7
# [../]
  [./TimeStepper]
    type = IterationAdaptiveDT
    dt = 0.01
    growth_factor = 2.0
    cutback_factor = 0.5
  [../]
[]

[Outputs]
  exodus = true
  perf_graph = true
[]
