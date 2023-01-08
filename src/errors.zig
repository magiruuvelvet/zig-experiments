pub const BaseError = error {
    ErrorCode1,
    ErrorCode2,
};

pub const InheritedError = BaseError || error {
    InheritedError1,
};
