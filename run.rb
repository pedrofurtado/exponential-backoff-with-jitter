max_retries = 5
retries = 0
attempts = []

def do_something
  raise 'crashed!'
end

begin
  do_something
rescue => e
  if retries < max_retries
    retries += 1
    exponential_backoff_time = (2 ** retries)
    jitter = rand(20) # random number between 0 and 19
    sleep_time = exponential_backoff_time + jitter

    attempt = {
      retries: retries,
      exponential_backoff_time: exponential_backoff_time,
      jitter: jitter,
      sleep_time: sleep_time
    }
    attempts << attempt

    puts "Sleeping #{sleep_time} seconds ... | Attempt #{attempt}"
    sleep(sleep_time)

    retry
  else
    puts "Giving up after #{retries} attempts. Got error: #{e.message}"
  end
end
