%assign if_i 0

%macro if 3
    cmp %1, %3
    %push if_context
    %assign if_i if_i + 1
    %assign %$lbl if_i
    
    %ifidni %2, ==
        jne endif_%$lbl
    %elifidni %2, !=
        je endif_%$lbl
    %elifidni %2, <
        jge endif_%$lbl
    %elifidni %2, <=
        jg endif_%$lbl
    %elifidni %2, =<
        jg endif_%$lbl
    %elifidni %2, >
        jle endif_%$lbl
    %elifidni %2, >=
        jl endif_%$lbl
    %elifidni %2, =>
        jl endif_%$lbl
    %else
        %error "Unknown comparison operator in if macro!"
    %endif
    if_%$lbl:
%endmacro

%macro ifu 3
    cmp %1, %3
    %push if_context
    %assign if_i if_i + 1
    %assign %$lbl if_i

    %ifidni %2, ==
        jne endif_%$lbl
    %elifidni %2, !=
        je endif_%$lbl
    %elifidni %2, <
        jnb endif_%$lbl      ; или jae (unsigned ниже -> инверсия: не ниже)
    %elifidni %2, >
        jbe endif_%$lbl      ; или jna (unsigned выше -> инверсия: не выше)
    %elifidni %2, <=
    %elifidni %2, =<
        ja endif_%$lbl       ; unsigned ниже или равно -> инверсия: строго выше
    %elifidni %2, >=
    %elifidni %2, =>
        jb endif_%$lbl       ; unsigned выше или равно -> инверсия: строго ниже
    %else
        %error "Unknown unsigned comparison operator in ifu macro!"
    %endif
%endmacro

%macro else 0
    jmp endel_%$lbl
    endif_%$lbl:
%endmacro

%macro endel 0
    %ifctx if_context
        endel_%$lbl:
        %pop
    %else
        %error "endel used without matching if!"
    %endif
%endmacro

%macro endif 0
    %ifctx if_context
        endif_%$lbl:
        %pop
    %else
        %error "endif used without matching if!"
    %endif
%endmacro
