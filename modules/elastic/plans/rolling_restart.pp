plan elastic::rolling_restart (
  TargetSpec        $targets,
) {
  # Iterate over the targets individually
  get_targets($targets).each |$target| {
    out::message("Restarting ${target.name}")
    run_script('elastic/restart_and_wait_green.sh', $target, '_run_as' => 'root')
  }
}
