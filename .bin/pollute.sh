. $HOME/.bin/utility_functions/functions.sh

checkEnv
if [[ $? -gt 0 ]]; then
  return;
fi

profiles=$(dir $GUIX_MANIFESTS | sed 's|\([^ ]\+\)\.scm|\1|g')
activateProfiles $profiles
