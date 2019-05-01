testset_num = testlab;

fprintf('  '); for i = 0:9; fprintf('& %4i', i); end;
for rett_tall = 0:9
    testset_num_estimated;
    testset_num;
    fprintf(' \\\\\n%i ', rett_tall)
    for klassifisert_tall = 0:9
        fprintf('& %4i', sum(testset_num_estimated(testset_num'==rett_tall) == klassifisert_tall));
    end
end
fprintf('\n\n')