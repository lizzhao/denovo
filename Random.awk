# This script is used for pick random list from whole list
BEGIN {
    if (!n) {
        print "Usage: random.awk -v n=[size] >output"
        exit
    }
    t = n
    srand()

}

NR <= n {
    pool[NR] = $0
    places[NR] = NR
    next

}

NR > n {
    t++
    M = int(rand()*t) + 1
    if (M <= n) {
        READ_NEXT_RECORD(M)
    }

}

END {
    if (NR < n) {
        print "Random.awk: Not enough records for sample" \
            > "/dev/stderr"
        exit
    }
    
    pad = length(NR)
    for (i in pool) {
        new_index = sprintf("%0" pad "d", i)
        newpool[new_index] = pool[i]
    }
    x = asorti(newpool, ordered)
    for (i = 1; i <= x; i++)
        print newpool[ordered[i]]

}

function READ_NEXT_RECORD(idx) {
    rec = places[idx]
    delete pool[rec]
    pool[NR] = $0
    places[idx] = NR  
}
