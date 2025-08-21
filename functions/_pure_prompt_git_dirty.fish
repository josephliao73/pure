function _pure_prompt_git_dirty
    set -l out

    set -l is_git_dirty (
        if command git rev-list --max-count=1 HEAD -- >/dev/null 2>&1
            not command git diff-index --ignore-submodules --cached --quiet HEAD -- >/dev/null 2>&1
        else
            not command git diff --staged --ignore-submodules --no-ext-diff --quiet --exit-code >/dev/null 2>&1
        end
        or not command git diff --ignore-submodules --no-ext-diff --quiet --exit-code >/dev/null 2>&1
        or command git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' >/dev/null 2>&1
        and echo true
    )

    if test -n "$is_git_dirty"
        set -l dirty_color (_pure_set_color $pure_color_git_dirty)
        set out "$dirty_color$pure_symbol_git_dirty"
    end

    set -l col_white  $__toaster_color_white;  test -n "$col_white";  or set col_white  F1F1F1
    set -l col_green  $__toaster_color_green;  test -n "$col_green";  or set col_green  A6E22E
    set -l col_lilac  $__toaster_color_lilac;  test -n "$col_lilac";  or set col_lilac  AE81FF

    set out "$out$(_pure_set_color $col_white) [^._.^]ﾉ"
    set out "$out$(_pure_set_color $col_green)彡"
    set out "$out$(_pure_set_color $col_lilac)ミ"

    echo "$out"
end

