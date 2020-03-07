import schemas;

public type Product record {
    schemas:Product data;
};

public type ProductList record {
    schemas:Product[] data;
    schemas:Paginator meta;
};
