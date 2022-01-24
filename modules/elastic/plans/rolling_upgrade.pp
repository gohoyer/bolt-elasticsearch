plan elastic::rolling_upgrade (
  TargetSpec        $targets,
  String            $version,
) {
  # Iterate over the targets individually
  get_targets($targets).each |$target| {
    out::message("Restarting ${target.name}")
    run_script('elastic/upgrade_and_wait_green.sh', $target, '_run_as' => 'root', 'arguments' => [$version])
  }
}
