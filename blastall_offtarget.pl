open(FH,$ARGV[0]);
@array=<FH>;
close FH;


%hash=('Dengue Virus [DENV]'=>'DEN_2908',
'HIV'=>'HIV1496',
'SARS Coronavirus'=>'SARS_251',
'Arenaviridae'=>'Arenaviridae_52',
'Bunyaviridae'=>'Bunyaviridae_87',
'Coronaviridae'=>'Coronaviridae_33',
'Filoviridae'=>'Filoviridae_6',
'Flaviviridae'=>'Flaviviridae_53',
'Hepadnaviridae'=>'Hepadnaviridae_8',
'Herpesviridae'=>'Herpesviridae_46',
'Orthomyxoviridae'=>'Orthomyxoviridae_69',
'Papillomaviridae'=>'Papillomaviridae_90',
'Paramyxoviridae'=>'Paramyxoviridae_33',
'Parvoviridae'=>'Parvoviridae_58',
'Picornaviridae'=>'Picornaviridae_63',
'Poxviridae'=>'Poxviridae_27',
'Reoviridae'=>'Reoviridae_459',
'West Nile Virus [WNV]'=>'WNV_512',
'Hepatitis A Virus [HAV]'=>'HAV_59',
'Hepatitis B Virus [HBV]'=>'HBV_2601',
'Hepatitis C Virus [HCV]'=>'HCV_908',
'Hepatitis B Virus [HBV]'=>'HBV_2601',
'Hepatitis B Virus [HBV]'=>'HBV_2601',
'Epstein-Barr Virus [EBV]'=>'EBV_5'
,'Hepatitis A+B+C+D+E Virus '=>'HEPA_ALL_3866'
,'BK polyomavirus'=>'BK_POLY_267'
,'Ebolavirus [EBOV]'=>'EBOLA_13'
,'Encephalomyocarditis virus'=>'ENCEPHALO_17'
,'Enterovirus [EV]'=>'ENTERO_464'
,'Hepatitis Delta virus [HDV]'=>'HDV_135'
,'Hepatitis E Virus [HEV]'=>'HEV_164'
,'Hendra Virus'=>'HENDRA'
,'Human Papillomavirus [HPV]'=>'HPV_92'
,'Human Respiratory Syncytial Virus [HRSV]'=>'HRSV_10'
,'Herpes simplex Virus [HSV]'=>'HSV_61'
,'Influenza A Virus'=>'INFLU_A_40'
,'Influenza B Virus'=>'INFLU_B_3'
,'Influenza C Virus'=>'INFLU_C_138'
,'Influenza_A+B+C_Virus'=>'INFLU_A_B_C_181'
,'John Cunningham virus [JCV]'=>'JC_poly_436'
,'Japanese Encephalitis Virus [JE]'=>'JEV_77'
,'La Crosse Virus'=>'LACRO_54'
,'Lassa Virus'=>'LASS_19'
,'Measles Virus'=>'Measles_44'
,'Henipavirus'=>'NIPAH_8'
,'Poliovirus'=>'POL_153'
,'Human Rhinovirus'=>'RHINO_138'
,'Human rotavirus'=>'Rota_3918'
,'Vaccinia '=>'Vaccinia_23'
,'Sendai Virus'=>'SAND_21'
,'Chikungunya Virus'=>'CHICKEN_75'
,'Hazara nairovirus'=>''
,'Rabies'=>'RABIES_43'
,'St. Louis Encephalitis [SLE]'=>'ST_LOUIS_6'
,'Junin Virus'=>'JUNIN_17'
,'Rabies'=>'RABIES_43'
,'Semliki Forest Virus'=>'SEMLIKI_7'
,'Sindbis Virus'=>'SINDBIS_7'
,'St.Louis Encephalitis Virus'=>'ST_LOUIS_6'
,'Yellow Fever Virus'=>'YELLOW_25'
,'Human Coxsackievirus [CV]'=>'HEV_468'
,'Rotavirus'=>'HUMAN_ROTA_3918'
);











foreach $id_seq_name(@array){
chomp($id_seq_name);
($id,$seq,$virus)=split("\t",$id_seq_name);
$id=~s/\s//g;
$seq=~s/\s//g;
system "rm TEMP";
open(TEMP,">TEMP");
print TEMP ">$id\n";
print TEMP "$seq";





system "/home/nishant/blast-2.2.24/bin/blastall -p blastn -i TEMP -d ./db/$hash{$virus} -e 1000  -o ./result/$id.html -b 3000 -W 9 -m 1  -q -4 -r 5 "

}



__END__
 $hash=array('Dengue Virus [DENV]'=>'DEN_2908',
'HIV'=>'HIV1496',
'SARS Coronavirus'=>'SARS_251',
'Arenaviridae'=>'Arenaviridae_52',
'Bunyaviridae'=>'Bunyaviridae_87',
'Coronaviridae'=>'Coronaviridae_33',
'Filoviridae'=>'Filoviridae_6',
'Flaviviridae'=>'Flaviviridae_53',
'Hepadnaviridae'=>'Hepadnaviridae_8',
'Herpesviridae'=>'Herpesviridae_46',
'Orthomyxoviridae'=>'Orthomyxoviridae_69',
'Papillomaviridae'=>'Papillomaviridae_90',
'Paramyxoviridae'=>'Paramyxoviridae_33',
'Parvoviridae'=>'Parvoviridae_58',
'Picornaviridae'=>'Picornaviridae_63',
'Poxviridae'=>'Poxviridae_27',
'Reoviridae'=>'Reoviridae_459',
'West Nile Virus [WNV]'=>'WNV_512',
'Hepatitis A Virus [HAV]'=>'HAV_59',
'Hepatitis B Virus [HBV]'=>'HBV_2601',
'Hepatitis C Virus [HCV]'=>'HCV_908',
'Hepatitis B Virus [HBV]'=>'HBV_2601',
'Hepatitis B Virus [HBV]'=>'HBV_2601',
'Epstein-Barr Virus [EBV]'=>'EBV_5'
,'Hepatitis A+B+C+D+E Virus '=>'HEPA_ALL_3866'
,'BK polyomavirus'=>'BK_POLY_267'
,'Ebolavirus [EBOV]'=>'EBOLA_13'
,'Encephalomyocarditis virus'=>'ENCEPHALO_17'
,'Enterovirus [EV]'=>'ENTERO_464'
,'Hepatitis Delta virus [HDV]'=>'HDV_135'
,'Hepatitis E Virus [HEV]'=>'HEV_164'
,'Hendra Virus'=>'HENDRA'
,'Human Papillomavirus [HPV]'=>'HPV_92'
,'Human Respiratory Syncytial Virus [HRSV]'=>'HRSV_10'
,'Herpes simplex Virus [HSV]'=>'HSV_61'
,'Influenza A Virus'=>'INFLU_A_40'
,'Influenza B Virus'=>'INFLU_B_3'
,'Influenza C Virus'=>'INFLU_C_138'
,'Influenza_A+B+C_Virus'=>'INFLU_A_B_C_181'
,'John Cunningham virus [JCV]'=>'JC_poly_436'
,'Japanese Encephalitis Virus [JE]'=>'JEV_77'
,'La Crosse Virus'=>'LACRO_54'
,'Lassa Virus'=>'LASS_19'
,'Measles Virus'=>'Measles_44'
,'Henipavirus'=>'NIPAH_8'
,'Poliovirus'=>'POL_153'
,'Human Rhinovirus'=>'RHINO_138'
,'Human rotavirus'=>'Rota_3918'
,'Vaccinia '=>'Vaccinia_23'
,'Sendai Virus'=>'SAND_21'
,'Chikungunya Virus'=>'CHICKEN_75'
,'Hazara nairovirus'=>''
,'Rabies'=>'RABIES_43'
,'St. Louis Encephalitis [SLE]'=>'ST_LOUIS_6'
,'Junin Virus'=>'JUNIN_17'
,'Rabies'=>'RABIES_43'
,'Semliki Forest Virus'=>'SEMLIKI_7'
,'Sindbis Virus'=>'SINDBIS_7'
,'St.Louis Encephalitis Virus'=>'ST_LOUIS_6'
,'Yellow Fever Virus'=>'YELLOW_25'
,'Human Coxsackievirus [CV]'=>'HEV_468'
,'Rotavirus'=>'HUMAN_ROTA_3918'
);

