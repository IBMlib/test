ccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c     
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      module run_context
      use input_parser
      implicit none
      private                     ! default visibility

      type(control_file) :: simulation_file
      character*999      :: program_name
      logical            :: module_is_initialized = .false.

      character*(*), parameter :: args         = " <input_file> "
      character*(*), parameter :: syntax_error = "syntax error, usage: "


c.....set public calling interface

      public simulation_file
      public program_name
      public init_run_context
      public close_run_context

      contains
      

      subroutine init_run_context()
c---------------------------------------------------------
      integer, external :: iargc
      character*999     :: str
      integer           :: iarg, narg
      character*10      :: date, time, zone
      integer           :: values(8)
c---------------------------------------------------------

c.....get program name and start time
      call getarg(0, program_name)         ! program name
      write(*, 462) trim(adjustl(program_name))

      call date_and_time(date, time, zone, values)
      write(*, 464) values(1:3), values(5:7)

 462  format ("program name       = ", a)
 464  format ("program start date = ", i4,2i3, " - ", 
     +        i2.2,":",i2.2,":",i2.2)

c.....retrieve command line arguments
      narg = iargc()
      if (narg < 1) then   ! no input file
         write(*,*) trim(syntax_error//trim(program_name)//args)
         stop
      endif

      call getarg(1,str)
      write(*,*) "Simulation parameters from file ",trim(adjustl(str))
      
      call open_control_file(str, simulation_file)

      module_is_initialized = .true.

      end subroutine init_run_context
      



      subroutine close_run_context()
c---------------------------------------------------------
      if (module_is_initialized) then
         call close_control_file(simulation_file)
      endif
      module_is_initialized = .false.
      end subroutine close_run_context



      end module 
      

      
      