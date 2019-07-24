MODULE VTK_Serial_file
    USE XML,            ONLY : xml_file_dt, xml_element_dt
    USE vtk_attributes, ONLY : attribute, attributes
    USE vtk_datasets,   ONLY : dataset
    USE VTK_piece_element, ONLY : piece_dt
    USE VTK_element, ONLY : VTK_element_dt
    IMPLICIT NONE
    !! author: Ian Porter
    !! date: 05/06/2019
    !!
    !! This is the basic file for a serial VTK file
    !!

    PRIVATE
    PUBLIC :: serial_file

    TYPE, EXTENDS(xml_file_dt) :: VTK_file_dt
        CLASS(VTK_element_dt), ALLOCATABLE :: VTK_data
    CONTAINS
        PROCEDURE, PRIVATE :: deallocate_VTK_file_dt
        GENERIC, PUBLIC :: deallocate_file => deallocate_VTK_file_dt
    END TYPE VTK_file_dt

    TYPE(VTK_file_dt), ALLOCATABLE :: serial_file    !! Serial VTK file
!   TYPE(VTK_file_dt), ALLOCATABLE :: parallel_file  !! Parallel VTK file
                                                     !! Parallel file is a TODO for future work

    INTERFACE

        RECURSIVE MODULE SUBROUTINE deallocate_VTK_file_dt (foo)
        IMPLICIT NONE
        !! gcc Work-around for deallocating a multi-dimension derived type w/ allocatable character strings
        CLASS(VTK_file_dt), INTENT(INOUT) :: foo

        END SUBROUTINE deallocate_VTK_file_dt

    END INTERFACE

END MODULE VTK_Serial_file
