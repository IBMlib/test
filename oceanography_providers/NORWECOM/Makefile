############################################################3
#              Makefile for physical_fields.mod 
############################################################

PBI_MAIN     = NORWECOM_pbi.f
PBI_INCLUDES = NORWECOM_interpolators.f
PBI_OBJS     = NORWECOM_grid_transforms.o horizontal_representation.o mesh_grid.o time_services.o 
GENERIC_DIR  = ../generic_elements

physical_fields.a: dependences.mk $(PBI_OBJS) physical_fields.o 
	ar rcs physical_fields.a $(PBI_OBJS) physical_fields.o

physical_fields.mod physical_fields.o: $(PBI_MAIN) $(PBI_INCLUDES) $(PBI_OBJS)
	$(FC) -c $(FCFLAGS) $(FPPFLAGS) $< -o $*.o


# --- interface assembling rules: point to variants that provides sub interfaces

horizontal_representation.f:
	ln -sf  $(GENERIC_DIR)/horizontal_representation/horizontal_representation_scan_staywet.f horizontal_representation.f

time_services.f:
	ln -sf $(GENERIC_DIR)/time_services.f

mesh_grid.f:
	ln -sf $(GENERIC_DIR)/mesh_grid.f  # same name


include $(COMMON_RULES)
FCFLAGS += -I/usr/local/include   # should contain netcdf.mod
VPATH   += /usr/local/include     # let gmake pick up prerequisite netcdf.mod

clean: FORCE
	-rm -f  *.o  *.a  *.mod  dependences.mk
	-find . -maxdepth 1 -type l |xargs rm

FORCE:

# --- Locally tag external modules that should not be build from this
#     makefile, but included via the module-search-path-include 
#     compiler directive (ifort: -I). Search paths inherited from 
#     calling makefiles
#     EXTRES = -x time_tools -x run_context

time_tools.mod geometry.mod constants.mod run_context.mod  input_parser.mod  netcdf.mod:
	echo "update of" $@ "suppressed"


