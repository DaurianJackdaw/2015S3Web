def is_prime(n)
	for i in 2..Math.sqrt(n)
		if n % i == 0
			return false
		end
	end

	true
end

def prime_generate(n)
	for prime in 2..n
		if is_prime(prime)
			puts prime
		end
	end
end

prime_generate(100000)