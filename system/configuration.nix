{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = ["nvidia-drm.modeset=1" "pci=noaer" "pcie_aspm=off" "intel_iommu=on"];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtl88x2bu
  ];
  

  networking.hostName = "nightfury"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/London";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;


  # NVIDIA drivers are unfree.
  nixpkgs.config.allowUnfree = true;

  
  systemd.services.nvidia-control-devices = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
  };  
  
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

  # Optionally, you may need to select the appropriate driver version for your specific GPU.
   hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  
   
    # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
   
  # Enable sound.
  #sound.enable = true;
  hardware.pulseaudio.enable = false;

  services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };  
  
  # Keeb
  hardware.keyboard.zsa.enable = true;
  hardware.openrazer.enable = true;
  hardware.openrazer.users = [ "g" ];
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.g = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "plugdev" "docker" "libvirtd"]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim 
    wget
    gnomeExtensions.blur-my-shell
    gnomeExtensions.tiling-assistant
    gnome.gnome-tweaks
    gnumake
    gcc
    pciutils
    file
    virt-manager
  ];

  programs.fish.enable = true;
  programs.steam.enable = true;

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    enableNvidia = true;
  };  
  
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_14; 
  };
  
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  
  # Fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
  
  
  virtualisation.libvirtd.enable = true;


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}

