require "spec_helper"

describe PasswordMailer do
  describe "reset_password" do
    let(:address) { 'arthur.dent@example.com' }
    let(:password) { '123456' }
    let(:mail) { PasswordMailer.reset_password(address, password) }

    it "renders the headers" do
      mail.subject.should eq("Reset hesla")
      mail.to.should eq([address])
      mail.from.should eq(["admin@politikaopen.sk"])
    end

    it "renders the body" do
      mail.body.encoded.should match("123456")
    end
  end

end
