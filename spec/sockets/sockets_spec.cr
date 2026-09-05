require "../spec_helper"
require "file_utils"

SOCKETS_HEADER = "  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode ref pointer drops"

TCP_FIXTURE  = "#{SOCKETS_HEADER}\n   4: 0100007F:A3C3 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 157858 1 0000000085c4fdbb 99 0 0 10 0\n"
TCP6_FIXTURE = "#{SOCKETS_HEADER}\n   0: 00000000000000000000000000000000:14EB 00000000000000000000000000000000:0000 0A 00000000:00000000 00:00000000 00000000   980        0 17992 1 00000000fe246dd7 99 0 0 10 5\n"
UDP_FIXTURE  = "#{SOCKETS_HEADER}\n 2807: 5B01A8C0:0044 00000000:0000 07 00000000:00000000 00:00000000 00000000   981        0 17170 2 00000000da060629 0\n"
UDP6_FIXTURE = "#{SOCKETS_HEADER}\n 3285: 000080FE00000000FF005450B6AD1DFE:0222 00000000000000000000000000000000:0000 07 00000000:00000000 00:00000000 00000000   981        0 17289 2 0000000041d378f3 0\n"

describe "Miniss::Sockets" do
  it "is created" do
    sockets = Miniss::Sockets.new
    sockets.should_not be_nil
  end

  describe "#tcpv4" do
    it "returns Array(Socket)" do
      sockets = Miniss::Sockets.new
      sockets.tcpv4.should be_a(Array(Miniss::Socket))
    end
  end

  describe "#tcpv6" do
    it "returns Array(Socket)" do
      sockets = Miniss::Sockets.new
      sockets.tcpv6.should be_a(Array(Miniss::Socket))
    end
  end

  describe "#udppv4" do
    it "returns Array(Socket)" do
      sockets = Miniss::Sockets.new
      sockets.udpv4.should be_a(Array(Miniss::Socket))
    end
  end

  describe "#udppv6" do
    it "returns Array(Socket)" do
      sockets = Miniss::Sockets.new
      sockets.udpv6.should be_a(Array(Miniss::Socket))
    end
  end

  describe "#all" do
    it "returns Array(Socket)" do
      sockets = Miniss::Sockets.new
      sockets.all.should be_a(Array(Miniss::Socket))
    end
  end

  describe "#base" do
    it "returns String" do
      sockets = Miniss::Sockets.new
      sockets.base.should be_a(String)
    end

    it "defaults to /proc/net" do
      sockets = Miniss::Sockets.new
      sockets.base.should eq "/proc/net"
    end
  end

  describe "custom base folder" do
    it "parses sockets files from the given base folder" do
      base = File.join(Dir.tempdir, "miniss-spec-#{Process.pid}")
      FileUtils.rm_rf(base)
      Dir.mkdir_p(base)
      File.write(File.join(base, "tcp"), TCP_FIXTURE)
      File.write(File.join(base, "tcp6"), TCP6_FIXTURE)
      File.write(File.join(base, "udp"), UDP_FIXTURE)
      File.write(File.join(base, "udp6"), UDP6_FIXTURE)
      sockets = Miniss::Sockets.new(base)
      sockets.tcpv4.size.should eq 1
      sockets.tcpv4[0].laddr.should eq "127.0.0.1:41923"
      sockets.tcpv4[0].raddr.should eq "0.0.0.0:0"
      sockets.tcpv4[0].state.should eq "LISTEN"
      sockets.tcpv6[0].laddr.should eq "[::]:5355"
      sockets.tcpv6[0].state.should eq "LISTEN"
      sockets.udpv4[0].laddr.should eq "192.168.1.91:68"
      sockets.udpv4[0].state.should eq "CLOSE"
      sockets.udpv6[0].laddr.should eq "[fe80::5054:ff:fe1d:adb6]:546"
      sockets.udpv6[0].state.should eq "CLOSE"
      FileUtils.rm_rf(base)
    end

    it "tolerates missing sockets files" do
      base = File.join(Dir.tempdir, "miniss-spec-#{Process.pid}")
      FileUtils.rm_rf(base)
      Dir.mkdir_p(base)
      File.write(File.join(base, "tcp"), TCP_FIXTURE)
      sockets = Miniss::Sockets.new(base)
      sockets.tcpv4.size.should eq 1
      sockets.tcpv6.should be_empty
      sockets.udpv4.should be_empty
      sockets.udpv6.should be_empty
      FileUtils.rm_rf(base)
    end

    it "tolerates a nonexistent base folder" do
      sockets = Miniss::Sockets.new(File.join(Dir.tempdir, "miniss-spec-nonexistent-#{Process.pid}"))
      sockets.all.should be_empty
    end
  end
end
