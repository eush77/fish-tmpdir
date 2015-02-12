function tmpdir
  if not set --global --query TMPDIR_TAB
    set --global --export TMPDIR_TAB (mkdir -p /tmp/tmpdir; and mktemp -d /tmp/tmpdir/XXXXXX)
  end
  cd $TMPDIR_TAB
end

function _tmpdir_on_exit --on-process-exit %self
  if set --global --query TMPDIR_TAB
    rm -rf $TMPDIR_TAB
  end
end
