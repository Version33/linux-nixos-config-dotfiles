{ writeShellScript, requireFile }:
let
  Serum2 = requireFile {
		name = "Install_Xfer_Serum2_2.0.22.exe";
		sha256 = "09f7lplg4md58sq5b6a3lwp6nvaw4333lnhr314rwlk4ar1xrbr6";
		url = "https://xferrecords.com/product_downloads/serum-2-0-22-for-windows/start";
	};
in writeShellScript "serum2" ''
  echo "--------------------"
  echo "Installing App"
  echo "--------------------"
  wine ${Serum2} /SP- /Silent /suppressmsgboxes
''