require "../spec_helper"

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
end
