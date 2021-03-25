env :PATH, ENV['PATH']
set :output, 'log/cron.log'
set :environment, :development

# every :sunday, at: '9pm' do
#   runner 'EmailDeliverJob.perform_later'
# end

every 1.minutes do
  runner 'EmailDeliverJob.perform_later'
end