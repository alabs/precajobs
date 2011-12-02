
def screenchot(url, file)
  system "xvfb-run cutycapt --url=#{url} --out=#{file}"
end
