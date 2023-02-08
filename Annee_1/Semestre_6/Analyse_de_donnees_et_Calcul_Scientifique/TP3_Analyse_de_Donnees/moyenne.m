function x_moy = moyenne(x)
    R = single(x(:,:,1));
    V = single(x(:,:,2));
    B = single(x(:,:,3));
    R_norm = R ./ max(1,R+V+B);
    V_norm = V ./ max(1,R+V+B);
    R_moy = mean(R_norm,'all');
    V_moy = mean(V_norm,'all');
    x_moy = [R_moy , V_moy];
end

