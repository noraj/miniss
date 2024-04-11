require "../spec_helper"

describe "Miniss::Socket" do
  it "is created" do
    so = create_test_socket_tcp_ipv6
    so.should_not be_nil
  end

  describe "#laddr" do
    it "returns String" do
      so = create_test_socket_tcp_ipv6
      so.laddr.should be_a(String)
    end

    it "returns correct value" do
      so = create_test_socket_tcp_ipv6
      so.laddr.should eq "[::]:5355"
    end
  end

  describe "#raddr" do
    it "returns String" do
      so = create_test_socket_tcp_ipv6
      so.raddr.should be_a(String)
    end

    it "returns correct value" do
      so = create_test_socket_tcp_ipv6
      so.raddr.should eq "[::]:0"
    end
  end

  describe "#state" do
    it "returns String" do
      so = create_test_socket_tcp_ipv6
      so.state.should be_a(String)
    end

    it "returns correct value" do
      so = create_test_socket_tcp_ipv6
      so.state.should eq "LISTEN"
    end
  end

  describe "#uid" do
    it "returns UInt32" do
      so = create_test_socket_tcp_ipv6
      so.uid.should be_a(UInt32)
    end

    it "returns correct value" do
      so = create_test_socket_tcp_ipv6
      so.uid.should eq 980
    end
  end

  describe "#uname" do
    it "returns String" do
      so = create_test_socket_tcp_ipv6
      so.uname.should be_a(String)
    end

    # depends on the system where it is executed
    # it "returns correct value" do
    #  so = create_test_socket_tcp_ipv6
    #  so.uname.should eq "systemd-resolve"
    # end
  end

  describe "#type" do
    it "returns Symbol" do
      so = create_test_socket_tcp_ipv6
      so.type.should be_a(Symbol)
    end

    it "returns correct value" do
      so = create_test_socket_tcp_ipv6
      so.type.should eq :tcp
    end
  end

  describe "#ipv" do
    it "returns UInt8" do
      so = create_test_socket_tcp_ipv6
      so.ipv.should be_a(UInt8)
    end

    it "returns correct value" do
      so = create_test_socket_tcp_ipv6
      so.ipv.should eq 6_u8
    end
  end
end
