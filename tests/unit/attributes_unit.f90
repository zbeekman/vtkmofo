MODULE vtk_attributes_unit_tests
    USE Precision,      ONLY : i4k, r8k
    USE vtk_attributes, ONLY : field_data_array
    IMPLICIT NONE
    !! author: Ian Porter
    !! date: 12/14/2017
    !!
    !! Unit testing for attributes
    !!
    PRIVATE
    PUBLIC :: vtk_attributes_unit
! Generic information
    INTEGER(i4k), PARAMETER :: n_types  = 8
    INTEGER(i4k), PARAMETER :: vtk_unit = 20
    CHARACTER(LEN=15), DIMENSION(n_types), PARAMETER :: filename    = &
      & [ 'scalar.vtk     ', &
      &   'vector.vtk     ', &
      &   'normal.vtk     ', &
      &   'texture.vtk    ', &
      &   'tensor.vtk     ', &
      &   'field.vtk      ', &
      &   'scalar_int.vtk ', &
      &   'tensor_int.vtk ' ]
! Scalar information
    REAL(r8k), DIMENSION(*),   PARAMETER :: scalar_vals = &
      & [ 0.5_r8k, 1.0_r8k, 2.0_r8k, 4.0_r8k, 2.0_r8k, 1.0_r8k, 0.5_r8k ]
    INTEGER(i4k), DIMENSION(*),   PARAMETER :: int_vals    = &
      & [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
! Vector information
    REAL(r8k), DIMENSION(2,3), PARAMETER :: vector_r_vals  = RESHAPE ( &
      & [ 0.5_r8k, 1.0_r8k, 0.5_r8k, &
      &   4.0_r8k, 2.0_r8k, 1.0_r8k ], [2,3])
    INTEGER(i4k), DIMENSION(3,3), PARAMETER :: vector_i_vals  = RESHAPE ( &
      & [ 10_i4k, 10_i4k, 10_i4k, &
      &   20_i4k, 20_i4k, 20_i4k, &
      &   30_i4k, 30_i4k, 30_i4k ], [3,3])
! Normal information
    REAL(r8k), DIMENSION(4,3), PARAMETER :: normal_r_vals  = RESHAPE ( &
      & [ 0.5_r8k, 1.0_r8k, 0.5_r8k, &
      &   1.0_r8k, 1.0_r8k, 1.0_r8k, &
      &   1.0_r8k, 0.5_r8k, 1.0_r8k, &
      &   1.0_r8k, 0.9_r8k, 1.0_r8k ], [4,3])
    INTEGER(i4k), DIMENSION(4,3), PARAMETER :: normal_i_vals  = RESHAPE ( &
      & [  1_i4k, 0_i4k, -1_i4k, &
      &   -1_i4k, 0_i4k,  1_i4k, &
      &    1_i4k, 0_i4k, -1_i4k, &
      &   -1_i4k, 0_i4k,  1_i4k ], [4,3])
! Texture information
    REAL(r8k), DIMENSION(6,2), PARAMETER :: texture_r_vals = RESHAPE ( &
      & [ 0.5_r8k, 1.0_r8k, &
      &   1.0_r8k, 1.0_r8k, &
      &   1.0_r8k, 0.5_r8k, &
      &   1.0_r8k, 0.9_r8k, &
      &   1.0_r8k, 0.9_r8k, &
      &   1.0_r8k, 0.9_r8k ], [6,2])
    INTEGER(i4k), DIMENSION(6,1), PARAMETER :: texture_i_vals = RESHAPE ( &
      & [ 0_i4k, &
      &   1_i4k, &
      &   2_i4k, &
      &   3_i4k, &
      &   4_i4k, &
      &   5_i4k ], [6,1])
! Tensor information
    REAL(r8k), DIMENSION(3,3), PARAMETER :: tensor_1     = RESHAPE ( &
      & [ 0.57_r8k, 1.00_r8k, 0.00_r8k, &
      &   1.00_r8k, 0.75_r8k, 0.80_r8k, &
      &   0.00_r8k, 0.80_r8k, 0.57_r8k ], [3,3])
    REAL(r8k), DIMENSION(3,3), PARAMETER :: tensor_2     = RESHAPE ( &
      & [ 1.57_r8k, 2.00_r8k, 1.00_r8k, &
      &   2.00_r8k, 1.75_r8k, 1.80_r8k, &
      &   1.00_r8k, 1.80_r8k, 1.57_r8k], [3,3])
    REAL(r8k), DIMENSION(3,3), PARAMETER :: tensor_3     = RESHAPE ( &
      & [ 2.57_r8k, 3.00_r8k, 2.00_r8k, &
      &   3.00_r8k, 2.75_r8k, 2.80_r8k, &
      &   2.00_r8k, 2.80_r8k, 2.57_r8k ], [3,3])
    REAL(r8k), DIMENSION(3,3), PARAMETER :: tensor_4     = RESHAPE ( &
      & [ 3.57_r8k, 4.00_r8k, 3.00_r8k, &
      &   4.00_r8k, 3.75_r8k, 3.80_r8k, &
      &   3.00_r8k, 3.80_r8k, 3.57_r8k ], [3,3])
    INTEGER(i4k), DIMENSION(3,3), PARAMETER :: tensor_5     = RESHAPE ( &
      & [ -1_i4k,  0_i4k,  1_i4k, &
      &   -2_i4k, -1_i4k,  0_i4k, &
      &   -3_i4k, -2_i4k, -1_i4k ], [3,3])
    INTEGER(i4k), DIMENSION(3,3), PARAMETER :: tensor_6     = RESHAPE ( &
      & [ 1_i4k, 0_i4k,  1_i4k, &
      &   2_i4k, 1_i4k,  0_i4k, &
      &   3_i4k, 2_i4k,  1_i4k ], [3,3])
    REAL(r8k),    DIMENSION(4,3,3) :: tensor_r_vals
    INTEGER(i4k), DIMENSION(2,3,3) :: tensor_i_vals
! Fields information
    TYPE(field_data_array)               :: array_1, array_2
    TYPE(field_data_array), DIMENSION(2) :: array
    REAL(r8k), DIMENSION(3,3), PARAMETER :: data_1 = RESHAPE ( &
      & [ 200.0_r8k, 200.0_r8k, 200.0_r8k, &
      &   300.0_r8k, 400.0_r8k, 300.0_r8k, &
      &   500.0_r8k, 450.0_r8k, 500.0_r8k ], [3,3] )
    REAL(r8k), DIMENSION(2,5), PARAMETER :: data_2 = RESHAPE ( &
      & [ 20.0_r8k, 200.0_r8k, &
      &   25.0_r8k, 250.0_r8k, &
      &   30.0_r8k, 300.0_r8k, &
      &   35.0_r8k, 350.0_r8k, &
      &   40.0_r8k, 400.0_r8k ], [2,5] )

    CONTAINS

        SUBROUTINE vtk_attributes_unit (test_pass)
        USE vtk_attributes, ONLY : attribute, scalar, vector, normal, texture, tensor, field
        IMPLICIT NONE
        !!
        !! Loops over each attribute type, performs a write, then performs a read on a different attribute
        !! and compares the two to make sure they are identical
        CLASS(attribute), ALLOCATABLE :: vtk_type_1, vtk_type_2
        INTEGER(i4k)                  :: i
        LOGICAL, INTENT(OUT)          :: test_pass
        LOGICAL, DIMENSION(n_types)   :: individual_tests_pass

        DO i = 1, n_types
            IF (ALLOCATED(vtk_type_1)) DEALLOCATE(vtk_type_1)
            IF (ALLOCATED(vtk_type_2)) DEALLOCATE(vtk_type_2)
            SELECT CASE (i)
            CASE (1, 7)
                !! Scalar attribute
                ALLOCATE(scalar :: vtk_type_1, vtk_type_2)

                !! Data type is generated from the defined values above
                IF (i == 1) THEN
                    !! Test for reals
                    CALL vtk_type_1%init(dataname='temperature', numcomp=1, real1d=scalar_vals)
                ELSE IF (i == 7) THEN
                    !! Test for integers
                    CALL vtk_type_1%init(dataname='temperature', numcomp=1, int1d=int_vals)
                END IF
            CASE (2, 8)
                !! Vector attribute
                ALLOCATE(vector :: vtk_type_1, vtk_type_2)

                IF (i == 2) THEN
                    !! Test for reals
                    CALL vtk_type_1%init(dataname='temperature', numcomp=1, real2d=vector_r_vals)
                ELSE IF (i == 8) THEN
                    !! Test for integers
                    CALL vtk_type_1%init(dataname='temperature', numcomp=1, int2d=vector_i_vals)
                END IF
            CASE (3, 9)
                !! Normal attribute
                ALLOCATE(normal :: vtk_type_1, vtk_type_2)

                IF (i == 3) THEN
                    !! Test for reals
                    CALL vtk_type_1%init(dataname='normalized_temp', numcomp=1, real2d=normal_r_vals)
                ELSE IF (i == 9) THEN
                    !! Test for integers
                    CALL vtk_type_1%init(dataname='normalized_temp', numcomp=1, int2d=normal_i_vals)
                END IF
            CASE (4, 10)
                !! Texture attribute
                ALLOCATE(texture :: vtk_type_1, vtk_type_2)

                IF (i == 4) THEN
                    !! Test for reals
                    CALL vtk_type_1%init(dataname='textured_temp', numcomp=1, real2d=texture_r_vals)
                ELSE IF (i == 10) THEN
                    !! Test for integers
                    CALL vtk_type_1%init(dataname='textured_temp', numcomp=1, int2d=texture_i_vals)
                END IF
            CASE (5, 11)
                !! Tensor attribute
                ALLOCATE(tensor :: vtk_type_1, vtk_type_2)
                IF (i == 5) THEN
                    tensor_r_vals(1,:,:) = tensor_1; tensor_r_vals(2,:,:) = tensor_2
                    tensor_r_vals(3,:,:) = tensor_3; tensor_r_vals(4,:,:) = tensor_4
                    !! Data type is generated from the defined values above
                    CALL vtk_type_1%init(dataname='tensor_temp', numcomp=1, real3d=tensor_r_vals)
                ELSE IF (i == 11) THEN
                    tensor_i_vals(1,:,:) = tensor_5; tensor_i_vals(2,:,:) = tensor_6
                    !! Data type is generated from the defined values above
                    CALL vtk_type_1%init(dataname='tensor_temp', numcomp=1, int3d=tensor_i_vals)
                END IF
            CASE (6)
                !! Field attribute
                ALLOCATE(field :: vtk_type_1, vtk_type_2)
                array_1%name = 'temps';     array_1%numComponents=3; array_1%numTuples=3
                array_1%datatype='double';  array_1%data = data_1
                array_2%name = 'pressures'; array_2%numComponents=5; array_2%numTuples=2
                array_2%datatype='double';  array_2%data = data_2
                array(1) = array_1; array(2) = array_2

                !! Data type is generated from the defined values above
                CALL vtk_type_1%init(dataname='field_temp_press', numcomp=1, field_arrays=array)
            END SELECT

            OPEN (unit=vtk_unit, file=filename(i), form='formatted')
            CALL vtk_type_1%write(vtk_unit)
            CLOSE(unit=vtk_unit)

            !! Data type is generated from the read
            OPEN (unit=vtk_unit, file=filename(i), form='formatted')
            CALL vtk_type_2%read(vtk_unit)
            CLOSE(unit=vtk_unit)

            !! Compare the read file and the written/read file to ensure both types are the same
            individual_tests_pass(i) = .NOT. (vtk_type_1 .diff. vtk_type_2)
        END DO

        !! Compare the read file and the written/read file to ensure both types are the same
        test_pass = ALL(individual_tests_pass)

        END SUBROUTINE vtk_attributes_unit
END MODULE vtk_attributes_unit_tests

PROGRAM vtk_attributes_test
    USE vtk_attributes_unit_tests, ONLY : vtk_attributes_unit
    USE VTKmofoPassFail,           ONLY : all_tests_pass
    IMPLICIT NONE
    !! author: Ian Porter
    !! date: 12/14/2017
    !!
    !! Driver testing subroutine for the attributes information
    !!
    LOGICAL :: test_passes = .FALSE.

    CALL vtk_attributes_unit (test_passes)

    IF (test_passes) CALL all_tests_pass()

END PROGRAM vtk_attributes_test
