function tmpdir --description "cd into a fresh, one-time temporary directory"
  if set --global --query TMPDIR_TAB
    cd $TMPDIR_TAB
    rm -- {.*,*}
  else
    mkdir -p /tmp/tmpdir
    set --global TMPDIR_TAB (mktemp -d /tmp/tmpdir/XXXXXX)
    cd $TMPDIR_TAB
  end
end


function _tmpdir_on_exit --on-process-exit %self
  if set --global --query TMPDIR_TAB
    rm -rf $TMPDIR_TAB
  end
end
