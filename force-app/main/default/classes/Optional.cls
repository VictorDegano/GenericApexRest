public without sharing class Optional{
    private Object value{ get; set; }

    private void initialize(){
        this.value = null;
    }
    public Optional(){
        this.initialize();
    }

    public Optional(Object value){
        this.value = value;
    }

    public boolean isPresent(){
        return this.isNotNull(this.value);
    }

    public Object get(){
        if (this.isNull(this.value)){
            throw new NoSuchElementException('No hay valor presente en el Optional');
        }
        return this.value;
    }

    public Object orElse(Object defaultValue){
        return this.isNotNull(this.value) ? this.value : defaultValue;
    }

    public Object orElseGet(Supplier supplier){
        return this.isNotNull(this.value) ? this.value : supplier.get();
    }

    public Optional mapValues(Callback callback){
        return this.isNull(this.value) ? Optional.empty() : Optional.ofNullable(callback.call(value));
    }

    public static Optional empty(){
        return new Optional();
    }

    public static Optional of(Object value){
        return new Optional(value);
    }

    public static Optional ofNullable(Object value){
        return value == null ? Optional.empty() : Optional.of(value);
    }

    private Boolean isNull(Object value){
        return value == null;
    }

    private Boolean isNotNull(Object value){
        return ! this.isNull(value);
    }
}