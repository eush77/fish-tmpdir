function tmpdir
  if not set --global --query TMPDIR_TAB
    set --global --export TMPDIR_TAB (mkdir -p /tmp/tmpdir; and mktemp -d /tmp/tmpdir/XXXXXX)
  end
  if test -t 1
    cd $TMPDIR_TAB
  else
    echo $TMPDIR_TAB
  end
end

function _tmpdir_on_exit --on-process-exit %self
  if set --global --query TMPDIR_TAB; and test -d $TMPDIR_TAB
    rm -rf $TMPDIR_TAB
    rmdir /tmp/tmpdir >/dev/null ^&1; or true
  end
end
