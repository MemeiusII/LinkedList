program main
    use list
    implicit none

    class(t_list_handle), allocatable :: handle
    handle = create_list()

    call push_back(handle, "John", 4)
    call push_back(handle, "Jane", 4)
    call push_back(handle, "Joe", 3)
    call push_back(handle, "Jim", 3)

    call print_list(handle)
end program main
