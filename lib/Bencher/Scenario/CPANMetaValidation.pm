package Bencher::Scenario::CPANMetaValidation;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use CPAN::Meta::Validator;
use Data::Sah;
use Sah::Schema::cpan::meta20;

our $scenario = {
    summary => 'Benchmark CPAN Meta validation',
    participants => [
        {
            name => 'sah',
            summary => 'Data::Sah + Sah::Schema::cpan::meta20',
            code_template => 'state $v = Data::Sah::gen_validator("cpan::meta20*", {return_type=>"bool"}); $v->(<meta>) ? 1:0',
        },
        {
            name=>'cmv',
            summary => 'CPAN::Meta::Validator',
            code_template => 'my $cmv = CPAN::Meta::Validator->new(<meta>);
                              if ($cmv->is_valid) { return 1 } else { return 0 }',
        },
    ],
    datasets => [
        {name=>'invalid', result=>0, args=>{meta=>{
            "meta-spec"=>{url=>"http://search.cpan.org/perldoc?CPAN::Meta::Spec", version=>2},
        }}},
        {name=>'min_valid', result=>1, args=>{meta=>{
            name=>"a",
            version=>"1.0",
            "meta-spec"=>{url=>"http://search.cpan.org/perldoc?CPAN::Meta::Spec", version=>2},
            abstract=>"a",
            author=>["foo <foo\@example.com>"],
            dynamic_config=>0,
            generated_by=>"a",
            license=>["perl_5"],
            release_status=>"stable",
        }}},
    ],
};

1;
# ABSTRACT:
