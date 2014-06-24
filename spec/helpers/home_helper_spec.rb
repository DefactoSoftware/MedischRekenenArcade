require "spec_helper"
describe HomeHelper, type: :helper do
  include HomeHelper
  let(:morning) do
    Time.gm(DateTime.now.year, DateTime.now.month, DateTime.now.day, 8)
  end
  let(:afternoon) do
    Time.gm(DateTime.now.year, DateTime.now.month, DateTime.now.day, 16)
  end
  let(:evening) do
    Time.gm(DateTime.now.year, DateTime.now.month, DateTime.now.day, 19)
  end
  let(:night) do
    Time.gm(DateTime.now.year, DateTime.now.month, DateTime.now.day, 4)
  end

  describe "greetings_for_time" do
    it "Should return Good morning if time is morning" do
      expect(greeting_for_time(morning)).to eq(t("greetings.morning"))
    end

    it "Should return Good afternoon if time is afternoon" do
      expect(greeting_for_time(afternoon)).to eq(t("greetings.afternoon"))
    end

    it "Should return Good evening if time is evening" do
      expect(greeting_for_time(evening)).to eq(t("greetings.evening"))
    end

    it "Should return Good night if time is night" do
      expect(greeting_for_time(night)).to eq(t("greetings.night"))
    end
  end
end
