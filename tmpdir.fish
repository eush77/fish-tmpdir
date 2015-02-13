function tmpdir --description "cd into a fresh, one-time temporary directory"
  switch "$argv[1]"
    case -s --spawn
      if set --global --query TMPDIR_TAB
        set --local old_tmpdir_tab $TMPDIR_TAB
        set --erase TMPDIR_TAB
      end

      tmpdir
      fish
      cd -
      rm -rf -- $TMPDIR_TAB
      set --erase TMPDIR_TAB

      if set --local --query old_tmpdir_tab
        set --global TMPDIR_TAB $old_tmpdir_tab
      end

      return
  end

  if set --global --query TMPDIR_TAB
    cd $TMPDIR_TAB
    rm -rf -- {.*,*}
  else
    mkdir -p /tmp/tmpdir
    set --global TMPDIR_TAB (mktemp -d /tmp/tmpdir/XXXXXX)
    cd $TMPDIR_TAB
  end
end


function _tmpdir_on_exit --on-process-exit %self
  if set --global --query TMPDIR_TAB
    rm -rf -- $TMPDIR_TAB
  end
end
