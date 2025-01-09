class LegacyOrderProcessJob
  include Sidekiq::Job

  def perform(*args)
    puts "Call LegacyOrderProcessJob!"
  end
end
