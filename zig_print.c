// clang zig_print.c ./zig-out/lib/libzigshared.so -Wl,--rpath=./zig-out/lib -o call_zig_from_c

extern void zig_print(const char *ptr);

int main()
{
    zig_print("hello zig from c");
    return 0;
}
