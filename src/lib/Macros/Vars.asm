;%assign while_i 0

%macro var 1                     ; name
    ;%push while_context
    ;%assign while_i while_i + 1
    ;%assign %$lbl while_i
    
    ;%ifidni %2, ==
    ;%else
    ;    %error "Unknown comparison operator in while macro!"
    ;%endif
%endmacro