%assign while_i 0

%macro while 3
    %push while_context
    %assign while_i while_i + 1
    %assign %$lbl while_i
    while_%$lbl:
      cmp %1, %3
    
    %ifidni %2, ==
        jne endwhile_%$lbl
    %elifidni %2, !=
        je endwhile_%$lbl
    %elifidni %2, <
        jge endwhile_%$lbl
    %elifidni %2, <=
        jg endwhile_%$lbl
    %elifidni %2, =<
        jg endwhile_%$lbl
    %elifidni %2, >
        jle endwhile_%$lbl
    %elifidni %2, >=
        jl endwhile_%$lbl
    %elifidni %2, =>
        jl endwhile_%$lbl
    %else
        %error "Unknown comparison operator in while macro!"
    %endif
%endmacro

%macro continue 0
    %ifctx while_context
        jmp while_%$lbl
    %else
        %error "continue used without matching while!"
    %endif
%endmacro

%macro break 0
    %ifctx while_context
        jmp endwhile_%$lbl
    %else
        %error "break used without matching while!"
    %endif
%endmacro

%macro endwhile 0
    %ifctx while_context
        jmp while_%$lbl
        endwhile_%$lbl:
        %pop
    %else
        %error "endwhile used without matching while!"
    %endif
%endmacro