select trial, stack, start age, count(*) total, count(case when fit_n < 0.25 then 1 end) as localized, count(case when fit_n between 0.25 and 0.85 then 1 end) subdiffusive,  count(case when fit_n > 0.85 then 1 end) diffusive, round(4.2e-3/avg(case when fit_n < 0.25 then fit_A end), 3) 'G_0 [pN/μm]', round(4.2e-3/exp(std(case when fit_n < 0.25 then log(fit_A) end)), 3) δG_0, round(avg(case when fit_n > 0.85 then fit_A end)/4, 3) 'D [μm^2/s]', round(exp(std(case when fit_n > 0.85 then log(fit_A) end))/4, 3) δD from Stack join Probe using (trial, stack) where (fit_A > 0.2 or fit_n > 0.1) group by trial, stack order by trial, start;

