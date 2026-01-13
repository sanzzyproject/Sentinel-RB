class SystemCheck
  def initialize(config)
    @config = config
  end

  def check_all
    alerts = []
    
    disk = check_disk
    mem = check_memory
    cpu = check_cpu

    if disk[:usage] > @config['thresholds']['disk_usage']
      alerts << "⚠️ [DISK WARNING] Usage is at #{disk[:usage]}% (Threshold: #{@config['thresholds']['disk_usage']}%)"
    end

    if mem[:usage] > @config['thresholds']['memory_usage']
      alerts << "⚠️ [MEMORY WARNING] Usage is at #{mem[:usage]}% (Threshold: #{@config['thresholds']['memory_usage']}%)"
    end

    if cpu[:load] > @config['thresholds']['cpu_load']
      alerts << "⚠️ [CPU WARNING] Load Average is #{cpu[:load]} (Threshold: #{@config['thresholds']['cpu_load']})"
    end

    alerts
  end

  private

  # Menggunakan Shell command 'df'
  def check_disk
    raw = `df -h / | tail -1 | awk '{print $5}'`.strip
    { usage: raw.to_i }
  end

  # Menggunakan Shell command 'free'
  def check_memory
    # Mengambil total dan available memory
    data = `free -m | grep Mem | awk '{print $2, $3}'`.split
    total = data[0].to_f
    used = data[1].to_f
    percentage = ((used / total) * 100).round(2)
    { usage: percentage }
  end

  # Menggunakan Shell command 'uptime'
  def check_cpu
    # Mengambil load average 1 menit terakhir
    load_avg = `uptime | awk -F'load average:' '{ print $2 }' | awk -F',' '{ print $1 }'`.strip.to_f
    { load: load_avg }
  end
end
