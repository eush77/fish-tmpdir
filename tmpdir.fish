function tmpdir --description "cd into a fresh, one-time temporary directory"
  if not set --global --query TMPDIR_TAB
    mkdir -p /tmp/tmpdir
    set --global --export TMPDIR_TAB (mktemp -d /tmp/tmpdir/XXXXXX)
  end
  cd $TMPDIR_TAB
end


function _tmpdir_on_exit --on-process-exit %self
  if set --global --query TMPDIR_TAB
    rm -rf $TMPDIR_TAB
  end
end
