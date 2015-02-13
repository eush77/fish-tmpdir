function tmpdir --description "cd into a fresh, one-time temporary directory"
  function _tmpdir_clean
    functions -e _tmpdir_clean
    functions -e _tmpdir_usage
    functions -e _tmpdir
    functions -e _tmpdir_spawn
  end

  function _tmpdir_usage
    printf "Usage:  tmpdir\n"
    printf "        tmpdir [-s | --spawn]\n"
  end

  function _tmpdir
    if set --global --query TMPDIR_TAB
      cd $TMPDIR_TAB
      rm -rf -- {.*,*}
    else
      mkdir -p /tmp/tmpdir
      set --global TMPDIR_TAB (mktemp -d /tmp/tmpdir/XXXXXX)
      cd $TMPDIR_TAB
    end
  end

  function _tmpdir_spawn
    if set --global --query TMPDIR_TAB
      set --local old_tmpdir_tab $TMPDIR_TAB
      set --erase TMPDIR_TAB
    end

    _tmpdir
    fish
    cd -
    rm -rf -- $TMPDIR_TAB
    set --erase TMPDIR_TAB

    if set --local --query old_tmpdir_tab
      set --global TMPDIR_TAB $old_tmpdir_tab
    end
  end

  if test (count $argv) -eq 0
    _tmpdir
    _tmpdir_clean
    return
  end

  if test (count $argv) -eq 1
    switch "$argv[1]"
      case -s --spawn
        _tmpdir_spawn
        _tmpdir_clean
        return
    end
  end

  _tmpdir_usage
  _tmpdir_clean
  return 1
end


function _tmpdir_on_exit --on-process-exit %self
  if set --global --query TMPDIR_TAB
    rm -rf -- $TMPDIR_TAB
  end
end
