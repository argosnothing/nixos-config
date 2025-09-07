# Tie All the hosts together
{...}: {
  imports = [
    ./desktop
    ./laptop
    ./p51
  ];
}
