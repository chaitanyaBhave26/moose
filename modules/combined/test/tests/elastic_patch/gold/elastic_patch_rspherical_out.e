CDF      
      
len_string     !   len_line   Q   four      	time_step          len_name   !   num_dim       	num_nodes         num_elem      
num_el_blk        num_node_sets         num_el_in_blk1        num_nod_per_el1       num_el_in_blk2        num_nod_per_el2       num_el_in_blk3        num_nod_per_el3       num_nod_ns1       num_nod_ns2       num_nod_var       num_elem_var      num_info  �         api_version       @�
=   version       @�
=   floating_point_word_size            	file_size               int64_status             title         "ad_elastic_patch_rspherical_out.e      maximum_name_length                 $   
time_whole                            ��   	eb_status                             
�   eb_prop1               name      ID              
�   	ns_status         	                    
�   ns_prop1      	         name      ID              
�   coordx                             
�   coordy                             
�   coordz                                 eb_names                       d          ns_names      	                 D      �   
coor_names                         d      �   node_num_map                          ,   connect1      
            	elem_type         EDGE2               <   connect2                  	elem_type         EDGE2               D   connect3                  	elem_type         EDGE2               L   elem_num_map                          T   node_ns1                          `   node_ns2                          d   vals_nod_var1                                 ��   vals_nod_var2                                 ��   name_nod_var                       D      h   name_elem_var                          �      �   vals_elem_var1eb1            
                    ��   vals_elem_var2eb1            
                    ��   vals_elem_var3eb1            
                    �    vals_elem_var4eb1            
                    �   vals_elem_var1eb2                                �   vals_elem_var2eb2                                �   vals_elem_var3eb2                                �    vals_elem_var4eb2                                �(   vals_elem_var1eb3                                �0   vals_elem_var2eb3                                �8   vals_elem_var3eb3                                �@   vals_elem_var4eb3                                �H   elem_var_tab                       0      0   info_records                      �H      `                                      ?�b_���?�	9,�?��f��wP                                                                                                                                                                                                                                                                                                                                                                                         disp_x                           temp                               density                          stress_xx                        stress_yy                        stress_zz                                                            ####################                ?��1&�                        ?��1&�     # Created by MOOSE #                                                             ####################                                                             ### Command Line Arguments ###                                                    /Users/hansje/projects/sockeye/moose/modules/combined/combined-opt -i ad_ela... stic_patch_rspherical.i --error --error-unused --error-override --no-gdb-back... trace### Version Info ###                                                                                                                                         Framework Information:                                                           MOOSE Version:           git commit 060931b612 on 2020-06-08                     LibMesh Version:         c6e82b286ef5c2cecede458b5f9c7c1b1daa8e53                PETSc Version:           3.11.4                                                  SLEPc Version:           3.11.0                                                  Current Time:            Mon Jun  8 19:38:45 2020                                Executable Timestamp:    Mon Jun  8 19:29:13 2020                                                                                                                                                                                                  ### Input File ###                                                                                                                                                []                                                                                 inactive                       = (no_default)                                    initial_from_file_timestep     = LATEST                                          initial_from_file_var          = INVALID                                         element_order                  = AUTO                                            order                          = AUTO                                            side_order                     = AUTO                                            type                           = GAUSS                                         []                                                                                                                                                                [BCs]                                                                                                                                                               [./ur]                                                                             boundary                     = '1 2'                                             control_tags                 = INVALID                                           displacements                = disp_x                                            enable                       = 1                                                 extra_matrix_tags            = INVALID                                           extra_vector_tags            = INVALID                                           implicit                     = 1                                                 inactive                     = (no_default)                                      isObjectAction               = 1                                                 matrix_tags                  = system                                            type                         = FunctionDirichletBC                               use_displaced_mesh           = 0                                                 variable                     = disp_x                                            vector_tags                  = nontime                                           diag_save_in                 = INVALID                                           function                     = 3e-3*x                                            preset                       = 1                                                 save_in                      = INVALID                                           seed                         = 0                                               [../]                                                                          []                                                                                                                                                                [Executioner]                                                                      auto_preconditioning           = 1                                               inactive                       = (no_default)                                    isObjectAction                 = 1                                               type                           = Transient                                       abort_on_solve_fail            = 0                                               accept_on_max_picard_iteration = 0                                               automatic_scaling              = INVALID                                         compute_initial_residual_before_preset_bcs = 0                                   compute_scaling_once           = 1                                               contact_line_search_allowed_lambda_cuts = 2                                      contact_line_search_ltol       = INVALID                                         control_tags                   = (no_default)                                    custom_abs_tol                 = 1e-50                                           custom_rel_tol                 = 1e-08                                           direct_pp_value                = 0                                               disable_picard_residual_norm_check = 0                                           dt                             = 1                                               dtmax                          = 1e+30                                           dtmin                          = 2e-14                                           enable                         = 1                                               end_time                       = 1                                               l_abs_tol                      = 1e-50                                           l_max_its                      = 10000                                           l_tol                          = 1e-05                                           line_search                    = default                                         line_search_package            = petsc                                           max_xfem_update                = 4294967295                                      mffd_type                      = wp                                              n_startup_steps                = 0                                               nl_abs_step_tol                = 1e-50                                           nl_abs_tol                     = 1e-50                                           nl_div_tol                     = -1                                              nl_max_funcs                   = 10000                                           nl_max_its                     = 50                                              nl_rel_step_tol                = 1e-50                                           nl_rel_tol                     = 1e-08                                           num_grids                      = 1                                               num_steps                      = 4294967295                                      petsc_options                  = INVALID                                         petsc_options_iname            = INVALID                                         petsc_options_value            = INVALID                                         picard_abs_tol                 = 1e-50                                           picard_custom_pp               = INVALID                                         picard_force_norms             = 0                                               picard_max_its                 = 1                                               picard_rel_tol                 = 1e-08                                           relaxation_factor              = 1                                               relaxed_variables              = (no_default)                                    reset_dt                       = 0                                               resid_vs_jac_scaling_param     = 0                                               restart_file_base              = (no_default)                                    scaling_group_variables        = INVALID                                         scheme                         = implicit-euler                                  skip_exception_check           = 0                                               snesmf_reuse_base              = 1                                               solve_type                     = PJFNK                                           splitting                      = INVALID                                         ss_check_tol                   = 1e-08                                           ss_tmin                        = 0                                               start_time                     = 0                                               steady_state_detection         = 0                                               steady_state_start_time        = 0                                               steady_state_tolerance         = 1e-08                                           time_period_ends               = INVALID                                         time_period_starts             = INVALID                                         time_periods                   = INVALID                                         timestep_tolerance             = 2e-14                                           trans_ss_check                 = 0                                               update_xfem_at_timestep_begin  = 0                                               use_multiapp_dt                = 0                                               verbose                        = 0                                             []                                                                                                                                                                [GlobalParams]                                                                     displacements                  = disp_x                                        []                                                                                                                                                                [Kernels]                                                                                                                                                           [./heat]                                                                           inactive                     = (no_default)                                      isObjectAction               = 1                                                 type                         = TimeDerivative                                    block                        = INVALID                                           control_tags                 = Kernels                                           diag_save_in                 = INVALID                                           displacements                = disp_x                                            enable                       = 1                                                 extra_matrix_tags            = INVALID                                           extra_vector_tags            = INVALID                                           implicit                     = 1                                                 lumping                      = 0                                                 matrix_tags                  = 'system time'                                     save_in                      = INVALID                                           seed                         = 0                                                 use_displaced_mesh           = 0                                                 variable                     = temp                                              vector_tags                  = time                                            [../]                                                                          []                                                                                                                                                                [Materials]                                                                        inactive                       = (no_default)                                                                                                                     [./density]                                                                        inactive                     = (no_default)                                      isObjectAction               = 1                                                 type                         = ADDensity                                         block                        = INVALID                                           boundary                     = INVALID                                           compute                      = 1                                                 constant_on                  = NONE                                              control_tags                 = Materials                                         density                      = 0.283                                             displacements                = disp_x                                            enable                       = 1                                                 implicit                     = 1                                                 output_properties            = INVALID                                           outputs                      = all                                               seed                         = 0                                                 use_displaced_mesh           = 0                                               [../]                                                                                                                                                             [./elasticity_tensor]                                                              inactive                     = (no_default)                                      isObjectAction               = 1                                                 type                         = ComputeIsotropicElasticityTensor                  base_name                    = INVALID                                           block                        = INVALID                                           boundary                     = INVALID                                           bulk_modulus                 = INVALID                                           compute                      = 1                                                 constant_on                  = NONE                                              control_tags                 = Materials                                         elasticity_tensor_prefactor  = INVALID                                           enable                       = 1                                                 implicit                     = 1                                                 lambda                       = INVALID                                           output_properties            = INVALID                                           outputs                      = none                                              poissons_ratio               = 0.25                                              seed                         = 0                                                 shear_modulus                = INVALID                                           use_displaced_mesh           = 0                                                 youngs_modulus               = 1e+06                                           [../]                                                                                                                                                             [./stress]                                                                         inactive                     = (no_default)                                      isObjectAction               = 1                                                 type                         = ComputeStrainIncrementBasedStress                 base_name                    = INVALID                                           block                        = INVALID                                           boundary                     = INVALID                                           compute                      = 1                                                 constant_on                  = NONE                                              control_tags                 = Materials                                         enable                       = 1                                                 implicit                     = 1                                                 inelastic_strain_names       = INVALID                                           output_properties            = INVALID                                           outputs                      = none                                              seed                         = 0                                               [../]                                                                          []                                                                                                                                                                [Mesh]                                                                             displacements                  = disp_x                                          inactive                       = (no_default)                                    use_displaced_mesh             = 1                                               include_local_in_ghosting      = 0                                               output_ghosting                = 0                                               block_id                       = INVALID                                         block_name                     = INVALID                                         boundary_id                    = INVALID                                         boundary_name                  = INVALID                                         construct_side_list_from_node_list = 0                                           ghosted_boundaries             = INVALID                                         ghosted_boundaries_inflation   = INVALID                                         isObjectAction                 = 1                                               second_order                   = 0                                               skip_partitioning              = 0                                               type                           = FileMesh                                        uniform_refine                 = 0                                               allow_renumbering              = 1                                               centroid_partitioner_direction = INVALID                                         construct_node_list_from_side_list = 1                                           control_tags                   = (no_default)                                    dim                            = 1                                               enable                         = 1                                               file                           = /Users/hansje/projects/sockeye/moose/modul... es/combined/test/tests/elastic_patch/elastic_patch_rspherical.e                    ghosting_patch_size            = INVALID                                         max_leaf_size                  = 10                                              nemesis                        = 0                                               parallel_type                  = DEFAULT                                         partitioner                    = default                                         patch_size                     = 40                                              patch_update_strategy          = never                                         []                                                                                                                                                                [Mesh]                                                                           []                                                                                                                                                                [Mesh]                                                                           []                                                                                                                                                                [Modules]                                                                                                                                                           [./TensorMechanics]                                                                                                                                                 [./Master]                                                                         add_variables              = 0                                                   base_name                  = INVALID                                             decomposition_method       = TaylorExpansion                                     diag_save_in               = INVALID                                             displacements              = disp_x                                              eigenstrain_names          = INVALID                                             generate_output            = INVALID                                             global_strain              = INVALID                                             inactive                   = (no_default)                                        incremental                = INVALID                                             out_of_plane_direction     = z                                                   out_of_plane_pressure      = 0                                                   out_of_plane_strain        = INVALID                                             planar_formulation         = NONE                                                pressure_factor            = 1                                                   save_in                    = INVALID                                             scalar_out_of_plane_strain = INVALID                                             strain                     = SMALL                                               temperature                = temp                                                use_automatic_differentiation = 0                                                use_displaced_mesh         = 0                                                   use_finite_deform_jacobian = 0                                                   volumetric_locking_correction = 0                                                                                                                                 [./All]                                                                            add_variables            = 1                                                     additional_generate_output = INVALID                                             base_name                = INVALID                                               block                    = INVALID                                               cylindrical_axis_point1  = INVALID                                               cylindrical_axis_point2  = INVALID                                               decomposition_method     = TaylorExpansion                                       diag_save_in             = INVALID                                               direction                = INVALID                                               displacements            = disp_x                                                eigenstrain_names        = INVALID                                               extra_vector_tags        = INVALID                                               generate_output          = 'stress_xx stress_yy stress_zz'                       global_strain            = INVALID                                               inactive                 = (no_default)                                          incremental              = 1                                                     out_of_plane_direction   = z                                                     out_of_plane_pressure    = 0                                                     out_of_plane_strain      = INVALID                                               planar_formulation       = NONE                                                  pressure_factor          = 1                                                     save_in                  = INVALID                                               scalar_out_of_plane_strain = INVALID                                             scaling                  = INVALID                                               strain                   = SMALL                                                 strain_base_name         = INVALID                                               temperature              = temp                                                  use_automatic_differentiation = 0                                                use_displaced_mesh       = 0                                                     use_finite_deform_jacobian = 0                                                   volumetric_locking_correction = 0                                              [../]                                                                          [../]                                                                          [../]                                                                          []                                                                                                                                                                [Outputs]                                                                          append_date                    = 0                                               append_date_format             = INVALID                                         checkpoint                     = 0                                               color                          = 1                                               console                        = 1                                               controls                       = 0                                               csv                            = 0                                               dofmap                         = 0                                               execute_on                     = 'INITIAL TIMESTEP_END'                          exodus                         = 1                                               file_base                      = INVALID                                         gmv                            = 0                                               gnuplot                        = 0                                               hide                           = INVALID                                         inactive                       = (no_default)                                    interval                       = 1                                               nemesis                        = 0                                               output_if_base_contains        = INVALID                                         perf_graph                     = 0                                               print_linear_residuals         = 1                                               print_mesh_changed_info        = 0                                               print_perf_log                 = 0                                               show                           = INVALID                                         solution_history               = 0                                               sync_times                     = (no_default)                                    tecplot                        = 0                                               vtk                            = 0                                               xda                            = 0                                               xdr                            = 0                                               xml                            = 0                                             []                                                                                                                                                                [Problem]                                                                          inactive                       = (no_default)                                    isObjectAction                 = 1                                               name                           = 'MOOSE Problem'                                 type                           = FEProblem                                       library_name                   = (no_default)                                    library_path                   = (no_default)                                    object_names                   = INVALID                                         register_objects_from          = INVALID                                         block                          = INVALID                                         control_tags                   = (no_default)                                    coord_type                     = RSPHERICAL                                      default_ghosting               = 0                                               enable                         = 1                                               error_on_jacobian_nonzero_reallocation = 0                                       extra_tag_matrices             = INVALID                                         extra_tag_vectors              = INVALID                                         force_restart                  = 0                                               ignore_zeros_in_jacobian       = 0                                               kernel_coverage_check          = 1                                               material_coverage_check        = 1                                               material_dependency_check      = 1                                               near_null_space_dimension      = 0                                               null_space_dimension           = 0                                               parallel_barrier_messaging     = 0                                               restart_file_base              = INVALID                                         rz_coord_axis                  = Y                                               skip_additional_restart_data   = 0                                               skip_nl_system_check           = 0                                               solve                          = 1                                               transpose_null_space_dimension = 0                                               use_nonlinear                  = 1                                             []                                                                                                                                                                [Variables]                                                                                                                                                         [./disp_x]                                                                         family                       = LAGRANGE                                          inactive                     = (no_default)                                      isObjectAction               = 1                                                 order                        = FIRST                                             scaling                      = INVALID                                           type                         = MooseVariableBase                                 initial_from_file_timestep   = LATEST                                            initial_from_file_var        = INVALID                                           block                        = INVALID                                           components                   = 1                                                 control_tags                 = Variables                                         eigen                        = 0                                                 enable                       = 1                                                 fv                           = 0                                                 initial_condition            = INVALID                                           outputs                      = INVALID                                           use_dual                     = 0                                               [../]                                                                                                                                                             [./temp]                                                                           family                       = LAGRANGE                                          inactive                     = (no_default)                                      isObjectAction               = 1                                                 order                        = FIRST                                             scaling                      = INVALID                                           type                         = MooseVariableBase                                 initial_from_file_timestep   = LATEST                                            initial_from_file_var        = INVALID                                           block                        = INVALID                                           components                   = 1                                                 control_tags                 = Variables                                         eigen                        = 0                                                 enable                       = 1                                                 fv                           = 0                                                 initial_condition            = 117.56                                            outputs                      = INVALID                                           use_dual                     = 0                                               [../]                                                                          []                                                                                                                          @]c�
=p�@]c�
=p�@]c�
=p�@]c�
=p�?��1&�                        ?��1&�                        ?��1&�                        ?�              ?e���h��?k���0v?o�`6y�@]c�
=p�@]c�
=p�@]c�
=p�@]c�
=p�?��0�
�@�o����9@�o����9@�o����9?��0�
�@�o����A@�o����=@�o����=?��0��@�p  �s@�p   f�@�p   f�