function Write-TableRow{

    param(

        $Player,
        $Runs,
        $Balls,
        $SR

    )

    "{0,-28}{1,6}{2,6}{3,8}" -f `
        $Player,
        $Runs,
        $Balls,
        $SR

}