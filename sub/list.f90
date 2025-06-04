module list
    implicit none

    ! Scoping
    private
    public t_list_handle, create_list, push_back, print_list

    type t_node
        type(t_node), pointer :: next
        character(:), allocatable :: value
    end type t_node

    type t_list
        type(t_node), pointer :: head
        integer :: length
    end type t_list

    ! Opaque handle
    type t_list_handle
        private
        type(t_list), pointer :: list
    end type t_list_handle

    contains
    
        function create_list () result(handle)
            type(t_list_handle), allocatable :: handle

            allocate(handle)
            allocate(handle%list)
            handle%list%head => null()
            handle%list%length = 0
        end function create_list

        subroutine push_back ( handle, value, value_length )
            implicit none
            type(t_list_handle), intent(inout) :: handle
            type(t_node), pointer :: node
            character(len=*), intent(in) :: value
            integer, intent(in) :: value_length
            type(t_node), pointer :: current

            ! Create new node
            allocate(node)
            allocate(character(value_length) :: node%value)
            node%value = value(1:value_length)
            node%next => null()

            ! Add to list
            if(.not. associated(handle%list%head)) then
                handle%list%head => node
            else
                current => handle%list%head
                do while (associated(current%next))
                    current => current%next
                end do
                current%next => node
            end if

            handle%list%length = handle%list%length + 1
        end subroutine push_back

        subroutine print_list ( handle )
            type(t_list_handle), intent(in) :: handle
            type(t_node), pointer :: current

            if(associated(handle%list%head)) then
                current => handle%list%head
                print *, current%value
                do while (associated(current%next))
                    current => current%next
                    print *, current%value
                end do
            end if
        end subroutine print_list
end module list