require 'spec_helper'

module Henry
  describe CLI do

    it 'deploys' do
      expect(Henry::Deploy).to receive(:new) do
        double = instance_double(Henry::Deploy)
        expect(double).to receive(:perform)
        double
      end

      Henry::CLI.new.deploy
    end

  end
end
